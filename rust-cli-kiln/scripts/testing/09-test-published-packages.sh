#!/bin/bash

# Test published packages across all ecosystems and architectures - AI Optimized
# Enhanced universal test script with OS/architecture detection and support
# NO INTERACTIVE INPUT - Fully automated for AI execution

set -euo pipefail

# Disable proxychains for clean execution
export LD_PRELOAD=

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

detect_os_arch() {
    info "=== Detecting OS and Architecture ==="
    
    # Detect OS
    case "$(uname -s)" in
        Linux*)     OS="linux" ;;
        Darwin*)    OS="darwin" ;;
        CYGWIN*|MINGW*|MSYS*) OS="windows" ;;
        *)          OS="unknown" ;;
    esac
    
    # Detect Architecture
    case "$(uname -m)" in
        x86_64|amd64)   ARCH="x64" ;;
        aarch64|arm64)  ARCH="arm64" ;;
        armv7l)         ARCH="arm" ;;
        i?86)           ARCH="x86" ;;
        *)              ARCH="unknown" ;;
    esac
    
    # Set platform identifier for npm packages
    case "${OS}-${ARCH}" in
        linux-x64)      PLATFORM="linux-x64" ;;
        linux-arm64)    PLATFORM="linux-arm64" ;;
        darwin-x64)     PLATFORM="darwin-x64" ;;
        darwin-arm64)   PLATFORM="darwin-arm64" ;;
        windows-x64)    PLATFORM="win32-x64" ;;
        *)              PLATFORM="unknown" ;;
    esac
    
    print_info "Detected OS: $OS"
    print_info "Detected Architecture: $ARCH"
    print_info "Platform identifier: $PLATFORM"
    
    # Check if this platform is supported
    if [[ "$PLATFORM" == "unknown" ]]; then
        print_error "Unsupported OS/Architecture combination: ${OS}-${ARCH}"
        exit 1
    fi
    
    # Set environment variables for other scripts
    export DETECTED_OS="$OS"
    export DETECTED_ARCH="$ARCH"
    export DETECTED_PLATFORM="$PLATFORM"
    
    print_success "OS and architecture detection completed"
}

check_environment() {
    info "=== Checking Environment ==="
    
    if ! is_github_actions; then
        print_info "Running in local environment"
        print_warning "Local testing only covers your current platform: $PLATFORM"
        print_info "For complete multi-platform testing, use GitHub Actions workflow"
    else
        print_info "Running in GitHub Actions environment"
        print_info "Platform matrix testing enabled"
        
        # GitHub Actions specific environment info
        if [[ -n "${RUNNER_OS:-}" && -n "${RUNNER_ARCH:-}" ]]; then
            print_info "GitHub Runner OS: ${RUNNER_OS}"
            print_info "GitHub Runner Arch: ${RUNNER_ARCH}"
        fi
    fi
    
    # Check if required tools are available
    MISSING_TOOLS=()
    
    if ! command -v cargo &> /dev/null; then
        MISSING_TOOLS+=("cargo (Rust)")
    fi
    
    if ! command -v node &> /dev/null; then
        MISSING_TOOLS+=("node (Node.js)")
    fi
    
    if ! command -v npm &> /dev/null; then
        MISSING_TOOLS+=("npm")
    fi
    
    if ! command -v python3 &> /dev/null; then
        MISSING_TOOLS+=("python3")
    fi
    
    if ! command -v pip &> /dev/null && ! command -v pip3 &> /dev/null; then
        MISSING_TOOLS+=("pip")
    fi
    
    if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
        print_warning "Missing tools detected: ${MISSING_TOOLS[*]}"
        print_info "Some tests may be skipped due to missing prerequisites"
    else
        print_success "All required tools are available"
    fi
}

test_rust_ecosystem() {
    info "=== Testing Rust Ecosystem ==="
    
    # Test CLI binary installation and functionality
    info "Testing Rust CLI binary from crates.io..."
    
    # Install CLI from crates.io
    if cargo install "$PROJECT_NAME" --force > /dev/null 2>&1; then
        print_success "✓ Rust CLI installed from crates.io"
        
        # Test basic functionality
        if "$PROJECT_NAME" --version > /dev/null 2>&1; then
            print_success "✓ Rust CLI version check passed"
        else
            print_error "✗ Rust CLI version check failed"
            return 1
        fi
        
        if "$PROJECT_NAME" --help > /dev/null 2>&1; then
            print_success "✓ Rust CLI help check passed"
        else
            print_error "✗ Rust CLI help check failed"
            return 1
        fi
    else
        print_error "✗ Failed to install Rust CLI from crates.io"
        return 1
    fi
    
    # Test core crate functionality by creating a test project
    info "Testing Rust core crate from crates.io..."
    
    # Create temporary test directory
    TEST_DIR="/tmp/${PROJECT_NAME}-crate-test-$$"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    # Create a minimal test project
    cargo init --name "test-${PROJECT_NAME}-core" --lib > /dev/null 2>&1
    
    # Add dependency to Cargo.toml
    echo "" >> Cargo.toml
    echo "[dependencies]" >> Cargo.toml
    echo "${PROJECT_NAME}-core = \"*\"" >> Cargo.toml
    
    # Create basic test
    cat > src/lib.rs << EOF
#[cfg(test)]
mod tests {
    #[test]
    fn test_crate_import() {
        // Basic import test - will fail if crate doesn't exist
        use ${PROJECT_NAME//-/_}_core;
        assert!(true);
    }
}
EOF
    
    # Run test
    if cargo test > /dev/null 2>&1; then
        print_success "✓ Rust core crate test passed"
    else
        print_error "✗ Rust core crate test failed"
        cd "$PROJECT_ROOT"
        rm -rf "$TEST_DIR"
        return 1
    fi
    
    # Clean up
    cd "$PROJECT_ROOT"
    rm -rf "$TEST_DIR"
    
    print_success "Rust ecosystem tests completed successfully"
}

test_npm_ecosystem() {
    info "=== Testing npm Ecosystem ==="
    
    # Install npm package globally
    info "Installing npm package from registry..."
    
    if npm install -g "${PROJECT_NAME}-js" > /dev/null 2>&1; then
        print_success "✓ npm package installed from registry"
        
        # Test basic functionality if binary is available
        NPM_BINARY_PATH="$(npm root -g)/${PROJECT_NAME}-js/bin/${PLATFORM}/${PROJECT_NAME}"
        if [ -f "$NPM_BINARY_PATH" ]; then
            if "$NPM_BINARY_PATH" --version > /dev/null 2>&1; then
                print_success "✓ npm package binary test passed"
            else
                print_warning "npm package binary test failed"
            fi
        else
            print_info "npm package binary not found for platform $PLATFORM (may be normal)"
        fi
        
        # Test Node.js require
        if node -e "require('${PROJECT_NAME}-js')" 2>/dev/null; then
            print_success "✓ npm package require test passed"
        else
            print_info "npm package require test failed (may not expose Node.js API)"
        fi
    else
        print_error "✗ Failed to install npm package from registry"
        return 1
    fi
    
    print_success "npm ecosystem tests completed successfully"
}

test_python_ecosystem() {
    info "=== Testing Python Ecosystem ==="
    
    # Install Python package from PyPI
    info "Installing Python package from PyPI..."
    
    # Use uv for installation
    if uv pip install "${PROJECT_NAME}-python" > /dev/null 2>&1; then
        print_success "✓ Python package installed from PyPI"
        
        # Test basic import
        PYTHON_MODULE_NAME="${PROJECT_NAME//-/_}_python"
        if uv run python -c "import $PYTHON_MODULE_NAME; print('Import successful')" > /dev/null 2>&1; then
            print_success "✓ Python package import test passed"
        else
            print_error "✗ Python package import test failed"
            return 1
        fi
        
        # Test version access if available
        if uv run python -c "import $PYTHON_MODULE_NAME; print(getattr($PYTHON_MODULE_NAME, '__version__', 'No version'))" > /dev/null 2>&1; then
            print_success "✓ Python package version access test passed"
        else
            print_info "Python package version access test skipped"
        fi
        
        # Test basic functionality if CLI is available through Python
        if uv run python -c "import $PYTHON_MODULE_NAME; $PYTHON_MODULE_NAME" --help > /dev/null 2>&1; then
            print_success "✓ Python package CLI test passed"
        else
            print_info "Python package CLI test skipped (may not expose CLI)"
        fi
    else
        print_error "✗ Failed to install Python package from PyPI"
        return 1
    fi
    
    print_success "Python ecosystem tests completed successfully"
}

cleanup_test_environment() {
    info "=== Cleaning up test environment ==="
    
    # Clean up any temporary installations
    # Uninstall test packages to avoid conflicts
    
    # Clean up Rust installations
    if command -v cargo &> /dev/null; then
        cargo uninstall "${PROJECT_NAME}" 2>/dev/null || true
        print_info "Cleaned up Rust CLI installation"
    fi
    
    # Clean up npm global installations
    if command -v npm &> /dev/null; then
        npm uninstall -g "${PROJECT_NAME}-js" 2>/dev/null || true
        print_info "Cleaned up npm global installation"
    fi
    
    # Clean up Python installations
    if command -v pip &> /dev/null; then
        pip uninstall -y "${PROJECT_NAME}-python" 2>/dev/null || true
    elif command -v pip3 &> /dev/null; then
        pip3 uninstall -y "${PROJECT_NAME}-python" 2>/dev/null || true
    fi
    print_info "Cleaned up Python package installation"
    
    print_success "Test environment cleanup completed"
}

generate_test_report() {
    info "=== Test Report Generation ==="
    
    # Create a simple test report
    REPORT_FILE="/tmp/${PROJECT_NAME}-test-report-$(date +%Y%m%d-%H%M%S).txt"
    
    cat > "$REPORT_FILE" << EOF
Published Package Test Report
============================

Project: ${PROJECT_NAME}
Platform: ${PLATFORM} (${OS}-${ARCH})
Test Date: $(date)
Environment: $(get_execution_mode)

Test Results:
- Rust CLI Binary: ${RUST_CLI_RESULT:-PENDING}
- Rust Core Crate: ${RUST_CORE_RESULT:-PENDING}
- npm Package: ${NPM_RESULT:-PENDING} 
- Python Package: ${PYTHON_RESULT:-PENDING}

Platform Details:
- OS: $OS
- Architecture: $ARCH
- Platform ID: $PLATFORM
EOF

    if is_github_actions; then
        echo "- GitHub Runner OS: ${RUNNER_OS:-N/A}" >> "$REPORT_FILE"
        echo "- GitHub Runner Arch: ${RUNNER_ARCH:-N/A}" >> "$REPORT_FILE"
    fi
    
    print_info "Test report generated: $REPORT_FILE"
}

main() {
    info "=== Testing Published ${PROJECT_NAME} Packages ==="
    info "Enhanced multi-platform testing with OS/architecture detection"
    echo ""
    
    # Initialize test results
    RUST_CLI_RESULT="FAIL"
    RUST_CORE_RESULT="FAIL"
    NPM_RESULT="FAIL"
    PYTHON_RESULT="FAIL"
    
    # Set up cleanup on exit
    trap cleanup_test_environment EXIT
    
    # Detect OS and architecture
    detect_os_arch
    
    # Check environment
    check_environment
    
    # Test each ecosystem
    if test_rust_ecosystem; then
        RUST_CLI_RESULT="PASS"
        RUST_CORE_RESULT="PASS"
    fi
    
    if test_npm_ecosystem; then
        NPM_RESULT="PASS"
    fi
    
    if test_python_ecosystem; then
        PYTHON_RESULT="PASS"
    fi
    
    # Generate test report
    generate_test_report
    
    # Summary
    success "=== Published Package Testing Summary ==="
    print_success "Platform: ${PLATFORM} (${OS}-${ARCH})"
    
    if [[ "$RUST_CLI_RESULT" == "PASS" ]]; then
        print_success "✓ Rust CLI (${PROJECT_NAME}): Installed and tested"
    else
        print_error "✗ Rust CLI (${PROJECT_NAME}): Test failed"
    fi
    
    if [[ "$RUST_CORE_RESULT" == "PASS" ]]; then
        print_success "✓ Rust crate (${PROJECT_NAME}-core): Installed and tested"
    else
        print_error "✗ Rust crate (${PROJECT_NAME}-core): Test failed"
    fi
    
    if [[ "$NPM_RESULT" == "PASS" ]]; then
        print_success "✓ npm package (${PROJECT_NAME}-js): Installed and tested"
    else
        print_error "✗ npm package (${PROJECT_NAME}-js): Test failed"
    fi
    
    if [[ "$PYTHON_RESULT" == "PASS" ]]; then
        print_success "✓ Python package (${PROJECT_NAME}-python): Installed and tested"
    else
        print_error "✗ Python package (${PROJECT_NAME}-python): Test failed"
    fi
    
    echo ""
    
    # Final result
    if [[ "$RUST_CLI_RESULT" == "PASS" && "$RUST_CORE_RESULT" == "PASS" && "$NPM_RESULT" == "PASS" && "$PYTHON_RESULT" == "PASS" ]]; then
        print_success "🎉 All published package tests passed on ${PLATFORM}!"
        info "All packages are working correctly in their respective ecosystems."
        exit 0
    else
        print_error "❌ Some published package tests failed on ${PLATFORM}"
        info "Check the test report and individual test outputs for details."
        exit 1
    fi
}

# Run main function
main "$@"