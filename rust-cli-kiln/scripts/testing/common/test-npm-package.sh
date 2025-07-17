#!/bin/bash

# Test npm package functionality
# Usage: test-npm-package.sh <source_type> [package_path]
#   source_type: "local" or "published"
#   package_path: path to npm package (required for local, ignored for published)

set -eo pipefail

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../utils/common.sh"
source "$SCRIPT_DIR/test-utils.sh"

# Initialize project variables
init_project_vars

# Parse arguments
SOURCE_TYPE="${1:-published}"
PACKAGE_PATH="${2:-}"

# Main test function
test_npm_package() {
    info "Testing npm package functionality (${SOURCE_TYPE})"
    
    # Check if Node.js is available
    if ! check_command "node" || ! check_command "npm"; then
        error "Node.js and npm are required for npm package testing"
        return 1
    fi
    
    # Create test project
    local test_dir=$(create_test_dir "npm-test")
    cd "$test_dir"
    
    # Initialize npm project
    npm init -y >/dev/null 2>&1
    
    # Install package
    if is_published_test "$SOURCE_TYPE"; then
        info "Installing ${PROJECT_NAME}-js from npm..."
        if ! npm install "${PROJECT_NAME}-js" >/dev/null 2>&1; then
            error "Failed to install ${PROJECT_NAME}-js from npm"
            return 1
        fi
        PACKAGE_NAME="${PROJECT_NAME}-js"
    else
        # For local test, install from path
        if [ -z "$PACKAGE_PATH" ] || [ ! -d "$PACKAGE_PATH" ]; then
            error "Package path not found: $PACKAGE_PATH"
            return 1
        fi
        info "Installing ${PROJECT_NAME}-js from local path..."
        if ! npm install "$PACKAGE_PATH" >/dev/null 2>&1; then
            error "Failed to install from local path: $PACKAGE_PATH"
            return 1
        fi
        PACKAGE_NAME="${PROJECT_NAME}-js"
    fi
    
    # Test 1: CLI via npx
    run_test "CLI version via npx" "npx ${PROJECT_NAME} --version"
    run_test "CLI help via npx" "npx ${PROJECT_NAME} --help"
    
    # Test 2: Create test files and run CLI
    echo '{"name": "test", "value": 1}' > file1.json
    echo '{"name": "test", "value": 2}' > file2.json
    
    run_test "CLI diff functionality" "npx ${PROJECT_NAME} file1.json file2.json"
    run_test "CLI JSON output" "npx ${PROJECT_NAME} file1.json file2.json --output json"
    
    # Test 3: JavaScript API
    cat > test-api.js << 'EOF'
const { diff, diffString, isDiffaiAvailable, getVersion } = require('PACKAGE_NAME/lib.js');

async function runTests() {
    console.log('Testing JavaScript API...');
    
    // Test 1: Check if binary is available
    if (!isDiffaiAvailable()) {
        console.error('Binary not available');
        process.exit(1);
    }
    console.log('✓ Binary availability check passed');
    
    // Test 2: Get version
    try {
        const version = await getVersion();
        console.log(`✓ Version: ${version}`);
    } catch (error) {
        console.error('Version check failed:', error.message);
        process.exit(1);
    }
    
    // Test 3: Test diff function
    try {
        const result = await diff('file1.json', 'file2.json', {});
        console.log('✓ Diff function works');
        console.log(`Found ${result.length} differences`);
    } catch (error) {
        console.error('Diff function failed:', error.message);
        process.exit(1);
    }
    
    // Test 4: Test diffString function
    try {
        const result = await diffString('{"a": 1}', '{"a": 2}', 'json', { output: 'json' });
        console.log('✓ DiffString function works');
        console.log(`Found ${result.length} differences`);
    } catch (error) {
        console.error('DiffString function failed:', error.message);
        process.exit(1);
    }
    
    console.log('All JavaScript API tests passed!');
}

runTests().catch(console.error);
EOF
    
    # Replace PACKAGE_NAME placeholder
    sed -i "s/PACKAGE_NAME/${PACKAGE_NAME}/g" test-api.js
    
    run_test "JavaScript API functionality" "node test-api.js"
    
    # Test 4: Run package tests using standard npm test
    if is_published_test "$SOURCE_TYPE"; then
        # For published packages, run their npm test suite
        cd "node_modules/${PACKAGE_NAME}"
        if npm test >/dev/null 2>&1; then
            run_test "Package test suite" "npm test"
        else
            warning "No npm test script found in published package"
        fi
        cd "$test_dir"
    else
        # For local packages, run tests in the package directory
        if (cd "$PACKAGE_PATH" && npm test >/dev/null 2>&1); then
            run_test "Local package test suite" "(cd '$PACKAGE_PATH' && npm test)"
        else
            warning "No npm test script found in local package"
        fi
    fi
    
    # Test 5: Error handling
    if npx "${PROJECT_NAME}" nonexistent.json file1.json >/dev/null 2>&1; then
        error "Should fail with non-existent file"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    else
        success "Properly handles non-existent file"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    fi
    TESTS_RUN=$((TESTS_RUN + 1))
    
    cd "$PROJECT_ROOT"
    
    print_test_summary
}

# Run tests
test_npm_package