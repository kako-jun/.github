#!/bin/bash
set -euo pipefail

# Pre-release test Act 2 - Language wrapper testing
# This script tests npm and Python package functionality using common framework

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"
source "$SCRIPT_DIR/common/test-utils.sh"

# Initialize project variables
init_project_vars

# GitHub Actions environment simulation
export CARGO_TERM_COLOR=always

check_prerequisites() {
    info "Checking prerequisites..."
    
    # Check if Node.js is installed
    if ! check_command "node"; then
        error "Node.js is not installed. Required for npm package testing."
        exit 1
    fi
    
    # Check if npm is installed
    if ! check_command "npm"; then
        error "npm is not installed. Required for npm package testing."
        exit 1
    fi
    
    # Check if Python is installed
    if ! check_command "python3"; then
        error "Python 3 is not installed. Required for Python package testing."
        exit 1
    fi
    
    # Check if maturin is available in venv (activate if exists)
    if [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
    fi
    
    if ! check_command "maturin"; then
        error "maturin is not installed. This is a FAILURE condition for releases."
        error "Install maturin: source .venv/bin/activate && uv pip install maturin"
        exit 1
    fi
    
    success "Prerequisites check passed"
}

test_package_consistency() {
    info "=== Testing package consistency ==="
    
    # Run the local version check
    if ! "$SCRIPT_DIR/../release/03-check-local-versions.sh"; then
        error "Package consistency check failed"
        exit 1
    fi
    
    success "Package consistency check passed"
}

build_npm_package() {
    info "=== Building npm package ==="
    
    if [ ! -d "${PROJECT_NAME}-npm" ]; then
        error "${PROJECT_NAME}-npm directory not found"
        exit 1
    fi
    
    cd "${PROJECT_NAME}-npm"
    
    # Validate package structure
    info "Validating npm package structure..."
    
    if [ ! -f "package.json" ]; then
        error "package.json not found"
        exit 1
    fi
    
    # Validate package.json syntax
    if ! node -e "require('./package.json')"; then
        error "package.json is invalid"
        exit 1
    fi
    
    # Check required scripts exist
    if [ ! -f "scripts/download-all-binaries.js" ]; then
        error "scripts/download-all-binaries.js not found"
        exit 1
    fi
    
    # Test script syntax
    if ! node -c "scripts/download-all-binaries.js"; then
        error "Binary download script has syntax errors"
        exit 1
    fi
    
    # Test npm publish readiness (dry run)
    info "Testing npm publish readiness (dry run only)..."
    if ! npm publish --dry-run; then
        error "npm publish dry run failed"
        exit 1
    fi
    
    success "npm package build validation passed"
    
    cd "$PROJECT_ROOT"
}

build_python_package() {
    info "=== Building Python package ==="
    
    if [ ! -d "${PROJECT_NAME}-python" ]; then
        error "${PROJECT_NAME}-python directory not found"
        exit 1
    fi
    
    cd "${PROJECT_NAME}-python"
    
    # Validate package structure
    info "Validating Python package structure..."
    
    if [ ! -f "pyproject.toml" ]; then
        error "pyproject.toml not found"
        exit 1
    fi
    
    if [ ! -f "Cargo.toml" ]; then
        error "Cargo.toml not found"
        exit 1
    fi
    
    # Test maturin build
    info "Testing maturin build..."
    
    # Clean previous builds
    rm -rf target/ dist/ build/
    
    # Build wheel for local target
    LOCAL_TARGET=$(rustc -vV | grep host | cut -d' ' -f2)
    info "Building wheel for target: $LOCAL_TARGET"
    
    # Build with error tolerance for local testing
    if ! maturin build --release --target "$LOCAL_TARGET" --out dist 2>&1 | tee build.log; then
        # Check if failure is due to manylinux compatibility
        if grep -q "manylinux.*compliance" build.log; then
            warning "manylinux compatibility error (expected in local environment)"
            warning "This will work in GitHub Actions with manylinux container"
            
            # Try building with relaxed compatibility
            info "Attempting build with local compatibility..."
            if ! maturin build --release --target "$LOCAL_TARGET" --out dist --compatibility linux; then
                error "maturin build failed even with relaxed compatibility"
                exit 1
            fi
        else
            error "maturin build failed with non-manylinux error"
            cat build.log
            exit 1
        fi
    fi
    
    rm -f build.log
    
    # Verify wheel was created
    if [ ! -d "dist" ] || [ -z "$(ls -A dist)" ]; then
        error "No wheel files created in dist/"
        exit 1
    fi
    
    info "Wheel files created:"
    ls -la dist/
    
    success "Python package build passed"
    
    cd "$PROJECT_ROOT"
}

main() {
    info "=== Pre-release Test Act 2 - Language Wrapper Testing ==="
    info "This tests npm and Python package functionality using common framework"
    echo ""
    
    # Prerequisites check
    check_prerequisites
    
    # Test package consistency first
    test_package_consistency
    
    # Build packages to prepare for testing
    build_npm_package
    build_python_package
    
    # Test npm package using common framework
    info "=== Testing npm package functionality ==="
    "$SCRIPT_DIR/common/test-npm-package.sh" local "${PROJECT_NAME}-npm"
    
    # Test Python package using common framework
    info "=== Testing Python package functionality ==="
    "$SCRIPT_DIR/common/test-python-package.sh" local "${PROJECT_NAME}-python"
    
    success "=== Pre-release Test Act 2 PASSED ==="
    info "All wrapper package tests passed!"
    echo ""
    info "Both Act 1 and Act 2 completed successfully."
    info "Ready to create release tag with: ./github-shared/rust-cli-kiln/scripts/release/06-create-release-tag.sh"
}

# Run main function
main "$@"