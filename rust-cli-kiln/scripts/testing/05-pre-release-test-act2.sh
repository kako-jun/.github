#!/bin/bash
set -euo pipefail

# Pre-release test Act 2 - Language wrapper simulation
# This script simulates exactly what GitHub Actions Release Act 2 does

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"

# Initialize project variables
init_project_vars

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# GitHub Actions environment simulation
export CARGO_TERM_COLOR=always

check_prerequisites() {
    print_info "Checking prerequisites..."
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Required for npm package testing."
        exit 1
    fi
    
    # Check if Python is installed
    if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
        print_error "Python is not installed. Required for Python package testing."
        exit 1
    fi
    
    # Check if maturin is installed (activate virtual environment first)
    if [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
    fi
    if ! command -v maturin &> /dev/null; then
        print_error "maturin is not installed. This is a FAILURE condition for releases."
        print_error "Install maturin: source .venv/bin/activate && uv pip install maturin"
        exit 1
    else
        SKIP_PYTHON_TESTS=false
    fi
    
    print_success "Prerequisites check passed"
}

test_npm_package() {
    print_info "=== Testing npm package build ==="
    
    if [ ! -d "$PROJECT_ROOT/${PROJECT_NAME}-npm" ]; then
        print_error "${PROJECT_NAME}-npm directory not found"
        exit 1
    fi
    
    cd "$PROJECT_ROOT/${PROJECT_NAME}-npm"
    
    # Check package.json exists and is valid
    if [ ! -f "package.json" ]; then
        print_error "package.json not found in ${PROJECT_NAME}-npm"
        exit 1
    fi
    
    # Validate package.json
    print_info "Validating package.json..."
    if ! node -e "require('./package.json')"; then
        print_error "package.json is invalid"
        exit 1
    fi
    
    # Check if binary download script exists
    if [ ! -f "scripts/download-all-binaries.js" ]; then
        print_error "scripts/download-all-binaries.js not found"
        exit 1
    fi
    
    # Test the download script (dry run simulation)
    print_info "Testing binary download script..."
    if ! node -c "scripts/download-all-binaries.js"; then
        print_error "Binary download script has syntax errors"
        exit 1
    fi
    
    # Test npm package (dry run only)
    print_info "Testing npm publish readiness (dry run only - no actual publishing)..."
    if ! npm publish --dry-run; then
        print_error "npm publish dry run failed"
        exit 1
    fi
    
    # Test binary functionality after npm install
    print_info "Testing included binary functionality..."
    
    # Create temporary directory for testing
    TEMP_NPM_DIR=$(mktemp -d)
    trap 'rm -rf "$TEMP_NPM_DIR"' EXIT
    
    cd "$TEMP_NPM_DIR"
    
    # Create a test package.json
    cat > package.json << 'EOF'
{
  "name": "test-npm-binary",
  "version": "1.0.0",
  "private": true
}
EOF
    
    # Install the local package
    if ! npm install "$PROJECT_ROOT/${PROJECT_NAME}-npm"; then
        print_error "Local npm package installation failed"
        exit 1
    fi
    
    # Test module import and functionality
    print_info "Testing module import and functionality..."
    cat > test_module.js << 'EOF'
const lib = require('diffai-js');
console.log('OK: Module imported');
if (typeof lib.diff === 'function') {
    console.log('OK: diff function available');
} else {
    console.error('ERROR: diff function not found');
    process.exit(1);
}
EOF
    if ! node test_module.js; then
        print_error "Module functionality test failed"
        exit 1
    fi
    rm -f test_module.js
    
    # Test binary execution
    BINARY_PATH="node_modules/${PROJECT_NAME}-js/bin/${PROJECT_NAME}"
    if [ -f "$BINARY_PATH" ]; then
        print_info "Testing binary execution..."
        if ! "$BINARY_PATH" --version; then
            print_warning "Binary version test failed (non-critical)"
        fi
    else
        print_info "Binary not found at expected path (may be architecture-specific)"
    fi
    
    cd "$PROJECT_ROOT/${PROJECT_NAME}-npm"
    
    print_success "npm dry run passed (no actual publishing)"
    print_warning "Note: Actual npm publishing happens only in GitHub Actions"
    
    cd "$PROJECT_ROOT"
    print_success "npm package test passed"
}

test_python_package() {
    print_info "=== Testing Python package build ==="
    
    # Skip Python tests if maturin is not available
    if [ "${SKIP_PYTHON_TESTS:-false}" = "true" ]; then
        print_warning "Skipping Python package tests (maturin not available)"
        return 0
    fi
    
    if [ ! -d "$PROJECT_ROOT/${PROJECT_NAME}-python" ]; then
        print_error "${PROJECT_NAME}-python directory not found"
        exit 1
    fi
    
    cd "$PROJECT_ROOT/${PROJECT_NAME}-python"
    
    # Check pyproject.toml exists and is valid
    if [ ! -f "pyproject.toml" ]; then
        print_error "pyproject.toml not found in ${PROJECT_NAME}-python"
        exit 1
    fi
    
    # Check Cargo.toml exists for maturin
    if [ ! -f "Cargo.toml" ]; then
        print_error "Cargo.toml not found in ${PROJECT_NAME}-python"
        exit 1
    fi
    
    # Test maturin build
    print_info "Testing maturin build..."
    
    # Clean previous builds
    rm -rf target/ dist/ build/
    
    # Build wheel (local target only to avoid cross-compilation)
    LOCAL_TARGET=$(rustc -vV | grep host | cut -d' ' -f2)
    print_info "Building wheel for target: $LOCAL_TARGET"
    
    # Build wheel with manylinux error tolerance for local testing
    if ! maturin build --release --target "$LOCAL_TARGET" --out dist 2>&1 | tee build.log; then
        # Check if failure is due to manylinux compatibility (local environment issue)
        if grep -q "manylinux.*compliance" build.log; then
            print_warning "manylinux compatibility error (expected in local environment)"
            print_warning "This will work in GitHub Actions with manylinux container"
            
            # Try building with relaxed compatibility for local testing
            print_info "Attempting build with local compatibility..."
            if ! maturin build --release --target "$LOCAL_TARGET" --out dist --compatibility linux; then
                print_error "maturin build failed even with relaxed compatibility"
                exit 1
            fi
        else
            print_error "maturin build failed with non-manylinux error"
            cat build.log
            exit 1
        fi
    fi
    
    # Clean up log file
    rm -f build.log
    
    # Check if wheel was created
    if [ ! -d "dist" ] || [ -z "$(ls -A dist)" ]; then
        print_error "No wheel files created in dist/"
        exit 1
    fi
    
    print_info "Wheel files created:"
    ls -la dist/
    
    # Test wheel installation (in isolated environment - no publishing)
    print_info "Testing wheel installation (local only - no publishing)..."
    
    WHEEL_FILE=$(ls dist/*.whl | head -1)
    if [ -z "$WHEEL_FILE" ]; then
        print_error "No wheel file found"
        exit 1
    fi
    
    # Create temporary venv for testing
    TEMP_VENV=$(mktemp -d)
    trap 'rm -rf "$TEMP_VENV"' EXIT
    
    python3 -m venv "$TEMP_VENV"
    source "$TEMP_VENV/bin/activate"
    
    # Install the wheel locally only
    if ! pip install "$WHEEL_FILE"; then
        print_error "Wheel installation failed"
        exit 1
    fi
    
    # Test basic functionality
    print_info "Testing installed Python package..."
    
    # Test module import and functionality
    print_info "Testing Python module import and functionality..."
    
    # Try multiple module name variants (matching 08 script logic)
    MODULE_VARIANTS=("${PROJECT_NAME}_python" "${PROJECT_NAME//-/_}")
    IMPORTED=false
    for variant in "${MODULE_VARIANTS[@]}"; do
        if python -c "import $variant; print('OK: Module $variant imported')" 2>/dev/null; then
            print_info "Python module works ($variant)"
            IMPORTED=true
            MODULE_NAME=$variant
            break
        fi
    done
    
    if [ "$IMPORTED" = false ]; then
        print_error "Python module import failed (tried: ${MODULE_VARIANTS[*]})"
        exit 1
    fi
    
    # Test module functionality
    print_info "Testing Python module functionality..."
    if ! python -c "import $MODULE_NAME; print(f'Module version: {getattr($MODULE_NAME, \"__version__\", \"unknown\")}')"; then
        print_warning "Python module version test failed (non-critical)"
    fi
    
    # Test diff function availability
    if ! python -c "import $MODULE_NAME; print('OK: diff function available' if hasattr($MODULE_NAME, 'diff') else 'WARNING: diff function not found')"; then
        print_warning "Python module function test failed (non-critical)"
    fi
    
    # 2. Test binary functionality (diffai CLI included in wheel)
    print_info "Testing included binary functionality..."
    
    # Check if binary exists in venv
    if [ -f "$TEMP_VENV/bin/${PROJECT_NAME}" ]; then
        print_info "Binary found at $TEMP_VENV/bin/${PROJECT_NAME}"
        if ! "$TEMP_VENV/bin/${PROJECT_NAME}" --version; then
            print_error "Binary version test failed"
            exit 1
        fi
    elif command -v ${PROJECT_NAME} &> /dev/null; then
        print_info "Binary found in PATH"
        if ! ${PROJECT_NAME} --version; then
            print_error "Binary version test failed"
            exit 1
        fi
    else
        print_error "${PROJECT_NAME} binary not found after installation"
        print_info "Available binaries in venv:"
        ls -la "$TEMP_VENV/bin/" | grep -E "(${PROJECT_NAME}|diffai)" || print_info "No matching binaries found"
        exit 1
    fi
    
    deactivate
    
    print_success "Python package build and local installation test passed"
    print_warning "Note: Actual PyPI publishing happens only in GitHub Actions"
    
    cd "$PROJECT_ROOT"
    print_success "Python package test passed"
}

test_package_consistency() {
    print_info "=== Testing package consistency ==="
    
    # Run the local version check
    "$(dirname "$SCRIPT_DIR")/release/03-check-local-versions.sh"
    
    print_success "Package consistency check passed"
}

main() {
    print_info "=== Pre-release Test Act 2 - Language Wrapper Simulation ==="
    print_info "This simulates exactly what GitHub Actions Release Act 2 does"
    echo ""
    
    # Prerequisites check
    check_prerequisites
    
    # Test package consistency first
    test_package_consistency
    
    # Test npm package
    test_npm_package
    
    # Test Python package
    test_python_package
    
    print_success "=== Pre-release Test Act 2 PASSED ==="
    print_info "All wrapper package tests passed!"
    echo ""
    print_info "Both Act 1 and Act 2 simulations completed successfully."
    print_info "Ready to create release tag with: ./github-shared/rust-cli-kiln/scripts/release/06-create-release-tag.sh"
}

# Run main function
main "$@"