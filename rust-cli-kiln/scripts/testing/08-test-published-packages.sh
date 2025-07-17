#!/bin/bash

# Test published packages across all ecosystems
# Universal test script using common framework for any project with npm, Python, and Rust packages

set -e

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"
source "$SCRIPT_DIR/common/test-utils.sh"

# Initialize project variables
init_project_vars

main() {
    info "=== Testing Published ${PROJECT_NAME} Packages ==="
    info "This tests all published packages using the common test framework"
    echo ""
    
    # Test 1: Rust ecosystem (CLI + Core crate)
    info "=== Testing Rust ecosystem ==="
    "$SCRIPT_DIR/common/test-rust-binary.sh" published
    "$SCRIPT_DIR/common/test-rust-crate.sh" published
    
    # Test 2: npm package
    info "=== Testing npm ecosystem ==="
    "$SCRIPT_DIR/common/test-npm-package.sh" published
    
    # Test 3: Python package
    info "=== Testing Python ecosystem ==="
    "$SCRIPT_DIR/common/test-python-package.sh" published
    
    # Summary
    success "=== Published Package Testing Summary ==="
    success "✓ Rust CLI (${PROJECT_NAME}): Installed and tested"
    success "✓ Rust crate (${PROJECT_NAME}-core): Installed and tested"
    success "✓ npm package (${PROJECT_NAME}-js): Installed and tested"
    success "✓ Python package (${PROJECT_NAME}-python): Installed and tested"
    
    echo ""
    success "🎉 Published package testing completed successfully!"
    info "All packages are working correctly in their respective ecosystems."
}

# Run main function
main "$@"