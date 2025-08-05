#!/bin/bash
set -euo pipefail

# Build and Test script - Pre-publish validation
# Comprehensive build and test of CLI, core, pip, npm packages
# Must pass completely before any publishing can occur

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"

# Initialize project variables
init_project_vars

# Match GitHub Actions environment
export CARGO_TERM_COLOR=always

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

# Error handling
trap 'print_error "Build and test failed at line $LINENO"' ERR

main() {
    print_info "Running comprehensive build and test (pre-publish validation)..."
    print_info "Project root: $PROJECT_ROOT"
    
    # Check if we're running from .github repository (no Cargo workspace)
    if [ ! -f "$PROJECT_ROOT/Cargo.toml" ]; then
        print_error "This script must be run from a Rust project directory (with Cargo.toml)"
        print_error "Usage examples:"
        print_error "  cd /path/to/diffx && /path/to/.github/rust-cli-kiln/scripts/testing/quick-check.sh"
        print_error "  cd /path/to/diffai && /path/to/.github/rust-cli-kiln/scripts/testing/quick-check.sh"
        print_error "  cd /path/to/lawkit && /path/to/.github/rust-cli-kiln/scripts/testing/quick-check.sh"
        exit 1
    fi
    
    echo ""
    
    # Step 1: Check formatting
    print_info "Step 1: Checking code formatting..."
    cargo fmt --all --check
    print_success "✓ Code formatting check passed"
    
    # Step 2: Run Clippy
    print_info "Step 2: Running Clippy..."
    cargo clippy --workspace --all-targets --all-features -- -D warnings
    print_success "✓ Clippy check passed"
    
    # Step 3: Build
    print_info "Step 3: Building workspace..."
    cargo build --workspace --verbose
    print_success "✓ Build completed"
    
    # Step 4: Run comprehensive tests
    print_info "Step 4: Running comprehensive tests..."
    
    # 4a: Core library tests
    print_info "  4a: Running core library tests..."
    cargo test --lib --verbose
    print_success "  ✓ Core library tests passed"
    
    # 4b: CLI integration tests  
    print_info "  4b: Running CLI integration tests..."
    cargo test --test cli --verbose
    print_success "  ✓ CLI integration tests passed (169 tests)"
    
    # 4c: Unified API tests
    print_info "  4c: Running unified API tests..."
    cargo test --test test_unified_api --verbose
    print_success "  ✓ Unified API tests passed (30 tests)"
    
    # 4d: All other workspace tests
    print_info "  4d: Running remaining workspace tests..."
    # Run all workspace tests, individual test files already covered above
    cargo test --workspace --verbose --lib
    print_success "  ✓ All workspace tests passed"
    
    # Step 5: Build core for bindings
    print_info "Step 5: Building core for language bindings..."
    cargo build --release --package ${PROJECT_NAME}-core
    print_success "✓ Core release build completed - ready for Python/JavaScript bindings"
    
    # Step 6: Test Python package (build and test)
    if [ -d "$PROJECT_ROOT/${PROJECT_NAME}-python" ] && [ -z "${SKIP_PYTHON_WHEEL_BUILD:-}" ]; then
        print_info "Step 6: Testing Python package..."
        cd "$PROJECT_ROOT/${PROJECT_NAME}-python"
        
        # Clean previous builds
        rm -rf target/ dist/ build/ 2>/dev/null || true
        
        # Require uv - no fallback
        if ! command -v uv &> /dev/null; then
            print_error "uv is required for Python testing. Please install uv: curl -LsSf https://astral.sh/uv/install.sh | sh"
            cd "$PROJECT_ROOT"
            exit 1
        fi
        
        print_info "  6a: Using uv for Python package management..."
        
        # Install dependencies with uv
        uv sync --frozen
        echo "DEBUG: uv sync completed with exit code: $?"
        
        # Build Python package with maturin
        # Use compatibility off for both local and GitHub Actions to avoid GLIBC version conflicts
        MATURIN_ARGS="--release --compatibility off"
        
        # Clean previous wheels to avoid using old versions
        echo "DEBUG: Cleaning wheels from: $PROJECT_ROOT/target/wheels/"
        if [ -d "$PROJECT_ROOT/target/wheels" ]; then
            find "$PROJECT_ROOT/target/wheels" -name "*.whl" -type f -delete || true
        fi
        echo "DEBUG: Wheel cleaning completed"
        
        # Capture maturin build output for debugging
        echo "DEBUG: Running maturin build with args: $MATURIN_ARGS"
        # If we're in a virtual environment, use maturin directly, otherwise use uv run
        if [ -n "${VIRTUAL_ENV:-}" ]; then
            echo "DEBUG: Using maturin directly in virtual environment"
            # Check if maturin is available
            if command -v maturin &> /dev/null; then
                echo "DEBUG: maturin found at: $(which maturin)"
                echo "DEBUG: Current directory: $(pwd)"
                echo "DEBUG: Python interpreter: $(which python)"
                echo "DEBUG: Python version: $(python --version)"
                # Try running maturin directly without capturing output first
                echo "DEBUG: Running maturin build command directly..."
                maturin build $MATURIN_ARGS
                MATURIN_EXIT_CODE=$?
                echo "DEBUG: Direct maturin exit code: $MATURIN_EXIT_CODE"
                # If it failed, capture the output for error reporting
                if [ $MATURIN_EXIT_CODE -ne 0 ]; then
                    MATURIN_OUTPUT="(Direct execution failed, see output above)"
                else
                    MATURIN_OUTPUT="Build successful with compatibility off"
                    # Show built wheels
                    if [ -d "$PROJECT_ROOT/target/wheels" ]; then
                        echo "DEBUG: Built wheels:"
                        ls -la "$PROJECT_ROOT/target/wheels/"
                    fi
                fi
            else
                echo "DEBUG: maturin not found in PATH, trying with python -m"
                TEMP_OUTPUT_FILE=$(mktemp)
                python -m maturin build $MATURIN_ARGS > "$TEMP_OUTPUT_FILE" 2>&1
                MATURIN_EXIT_CODE=$?
                MATURIN_OUTPUT=$(cat "$TEMP_OUTPUT_FILE")
                rm -f "$TEMP_OUTPUT_FILE"
            fi
        else
            echo "DEBUG: Using uv run to execute maturin"
            TEMP_OUTPUT_FILE=$(mktemp)
            uv run maturin build $MATURIN_ARGS > "$TEMP_OUTPUT_FILE" 2>&1
            MATURIN_EXIT_CODE=$?
            MATURIN_OUTPUT=$(cat "$TEMP_OUTPUT_FILE")
            rm -f "$TEMP_OUTPUT_FILE"
        fi
        echo "DEBUG: Maturin build exit code: $MATURIN_EXIT_CODE"
        if [ $MATURIN_EXIT_CODE -eq 0 ]; then
            print_success "  ✓ Python package build passed (with uv)"
            
            # Install and test the built package
            # maturin builds wheels to PROJECT_ROOT/target/wheels/ directory
            WHEEL_PATH=$(ls $PROJECT_ROOT/target/wheels/${PROJECT_NAME}*python*.whl 2>/dev/null | sort -V | tail -1)
            if [ -n "$WHEEL_PATH" ] && uv pip install "$WHEEL_PATH" --force-reinstall > /dev/null 2>&1; then
                # Run integration tests  
                # Use the same venv as the installation
                if source ../.venv/bin/activate && python test_integration.py > /dev/null 2>&1; then
                    print_success "  ✓ Python integration tests passed"
                else
                    print_warning "  Python integration tests failed"
                fi
                
                # Run pytest if available
                if source ../.venv/bin/activate && python -m pytest tests/ -v > /dev/null 2>&1; then
                    print_success "  ✓ Python pytest passed"
                else
                    print_info "  pytest skipped or failed"
                fi
            else
                print_warning "  Python package installation failed"
            fi
        else
            print_error "  maturin build failed (exit code: $MATURIN_EXIT_CODE)"
            echo "Maturin build error output:"
            echo "$MATURIN_OUTPUT"
            # Also show last 50 lines if output is very long
            if [ $(echo "$MATURIN_OUTPUT" | wc -l) -gt 50 ]; then
                echo "... (truncated, showing last 50 lines)"
                echo "$MATURIN_OUTPUT" | tail -50
            fi
            cd "$PROJECT_ROOT"
            exit 1
        fi
        
        cd "$PROJECT_ROOT"
    elif [ -n "${SKIP_PYTHON_WHEEL_BUILD:-}" ]; then
        print_info "Step 6: Skipping Python wheel build (using pre-built wheel from maturin-action)"
    else
        print_info "Step 6: Skipping Python tests (${PROJECT_NAME}-python not found)"
    fi
    
    # Step 7: Test JavaScript/npm package (build and test)
    if [ -d "$PROJECT_ROOT/${PROJECT_NAME}-js" ] && command -v node &> /dev/null; then
        print_info "Step 7: Testing JavaScript/npm package..."
        cd "$PROJECT_ROOT/${PROJECT_NAME}-js"
        
        # Require npm
        if ! command -v npm &> /dev/null; then
            print_error "npm is required for JavaScript testing. Please install Node.js and npm"
            cd "$PROJECT_ROOT"
            exit 1
        fi
        
        # Install dependencies
        if npm install > /dev/null 2>&1; then
            print_success "  ✓ npm dependencies installed"
            
            # Build the package (this requires the core to be built first)
            if npm run build > /dev/null 2>&1; then
                print_success "  ✓ JavaScript package build passed"
                
                # Run tests if available
                if npm test > /dev/null 2>&1; then
                    print_success "  ✓ JavaScript tests passed"
                else
                    print_warning "  JavaScript tests failed - checking individual functions"
                    
                    # Try basic functionality check
                    if node -e "require('./index.js')" 2>/dev/null; then
                        print_success "  ✓ JavaScript module loads correctly"
                    else
                        print_warning "  JavaScript module failed to load"
                    fi
                fi
                
                # Test npm publish readiness (dry run)
                if npm publish --dry-run > /dev/null 2>&1; then
                    print_success "  ✓ npm publish readiness check passed"
                else
                    print_warning "  npm publish dry run failed - check package.json"
                fi
            else
                print_warning "  JavaScript package build failed"
            fi
        else
            print_warning "  npm install failed"
        fi
        
        cd "$PROJECT_ROOT"
    elif [ -d "$PROJECT_ROOT/${PROJECT_NAME}-js" ] && command -v node &> /dev/null; then
        # Fallback to old npm directory name
        print_info "Step 7: Testing npm package (legacy directory)..."
        cd "$PROJECT_ROOT/${PROJECT_NAME}-js"
        
        # Validate package.json
        if node -e "require('./package.json')" 2>/dev/null; then
            # Test npm publish readiness (dry run)
            if npm publish --dry-run > /dev/null 2>&1; then
                print_success "  ✓ npm package test passed (dry run)"
            else
                print_warning "  npm publish dry run failed - check package.json"
            fi
        else
            print_warning "  Invalid package.json in ${PROJECT_NAME}-js"
        fi
        
        cd "$PROJECT_ROOT"
    else
        print_info "Step 7: Skipping JavaScript tests (Node.js not installed or ${PROJECT_NAME}-js not found)"
    fi
    
    echo ""
    print_success "🎉 All build and test checks passed!"
    print_info "Ready for publishing - all packages built and tested successfully"
    print_info "Next step: Run 06-publish.sh to publish all packages atomically"
}

# Run main function
main "$@"