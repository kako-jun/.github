#!/bin/bash

# Test Rust CLI binary functionality
# Usage: test-rust-binary.sh <source_type> [binary_path]
#   source_type: "local" or "published"
#   binary_path: path to binary (required for local, ignored for published)

set -eo pipefail

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../utils/common.sh"
source "$SCRIPT_DIR/test-utils.sh"

# Initialize project variables
init_project_vars

# Parse arguments
SOURCE_TYPE="${1:-published}"
BINARY_PATH="${2:-}"

# Main test function
test_rust_binary() {
    info "Testing Rust CLI binary (${SOURCE_TYPE})"
    
    # Determine binary path
    if is_published_test "$SOURCE_TYPE"; then
        # For published test, install the CLI
        info "Installing ${PROJECT_NAME} from crates.io..."
        if ! cargo install "${PROJECT_NAME}" --force >/dev/null 2>&1; then
            error "Failed to install ${PROJECT_NAME} from crates.io"
            return 1
        fi
        BINARY_CMD="${PROJECT_NAME}"
    else
        # For local test, use provided path
        if [ -z "$BINARY_PATH" ] || [ ! -f "$BINARY_PATH" ]; then
            error "Binary not found at: $BINARY_PATH"
            return 1
        fi
        BINARY_CMD="$BINARY_PATH"
    fi
    
    # Test 1: Version command
    run_test "CLI version command" "$BINARY_CMD --version"
    
    # Test 2: Help command
    run_test "CLI help command" "$BINARY_CMD --help"
    
    # Test 3: Basic diff functionality
    local test_dir=$(create_test_dir "binary-test")
    cd "$test_dir"
    
    # Create test files
    echo '{"name": "test", "value": 1}' > file1.json
    echo '{"name": "test", "value": 2}' > file2.json
    
    run_test "Basic JSON diff" "$BINARY_CMD file1.json file2.json"
    
    # Test 4: Different output formats
    run_test "JSON output format" "$BINARY_CMD file1.json file2.json --output json"
    run_test "YAML output format" "$BINARY_CMD file1.json file2.json --output yaml"
    
    # Test 5: Verbose mode
    run_test "Verbose mode" "$BINARY_CMD file1.json file2.json --verbose"
    
    # Test 6: Error handling - non-existent file
    if $BINARY_CMD nonexistent.json file1.json >/dev/null 2>&1; then
        error "Should fail with non-existent file"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    else
        success "Properly handles non-existent file"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    fi
    TESTS_RUN=$((TESTS_RUN + 1))
    
    # Test 7: ML model support (if applicable)
    if [[ "${PROJECT_NAME}" == *"diffai"* ]] || [[ "${PROJECT_NAME}" == *"ml"* ]]; then
        # Use actual test fixtures for ML models
        if [[ -f "tests/fixtures/ml_models/simple_base.pt" ]] && [[ -f "tests/fixtures/ml_models/simple_modified.pt" ]]; then
            run_test "ML model diff" "$BINARY_CMD tests/fixtures/ml_models/simple_base.pt tests/fixtures/ml_models/simple_modified.pt"
        else
            echo "[INFO] ML model test skipped - test fixtures not found"
        fi
    fi
    
    # Test 8: Directory comparison
    mkdir -p dir1 dir2
    echo '{"test": 1}' > dir1/test.json
    echo '{"test": 2}' > dir2/test.json
    
    run_test "Directory comparison" "$BINARY_CMD dir1 dir2"
    
    cd "$PROJECT_ROOT"
    
    print_test_summary
}

# Run tests
test_rust_binary