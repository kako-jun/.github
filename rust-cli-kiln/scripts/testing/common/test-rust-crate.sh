#!/bin/bash

# Test Rust crate functionality
# Usage: test-rust-crate.sh <source_type> [crate_path]
#   source_type: "local" or "published"
#   crate_path: path to crate (required for local, ignored for published)

set -eo pipefail

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../utils/common.sh"
source "$SCRIPT_DIR/test-utils.sh"

# Initialize project variables
init_project_vars

# Parse arguments
SOURCE_TYPE="${1:-published}"
CRATE_PATH="${2:-}"

# Main test function
test_rust_crate() {
    info "Testing Rust crate functionality (${SOURCE_TYPE})"
    
    # Create test project
    local test_dir=$(create_test_dir "crate-test")
    cd "$test_dir"
    
    # Initialize cargo project
    cargo init --name test-project >/dev/null 2>&1
    
    # Create basic Cargo.toml
    cat > Cargo.toml << 'EOF'
[package]
name = "test-project"
version = "0.1.0"
edition = "2021"

[dependencies]
EOF
    
    # Add crate dependency
    if is_published_test "$SOURCE_TYPE"; then
        info "Adding ${PROJECT_NAME}-core from crates.io..."
        if ! cargo add "${PROJECT_NAME}-core" >/dev/null 2>&1; then
            error "Failed to add ${PROJECT_NAME}-core from crates.io"
            return 1
        fi
    else
        # For local test, add path dependency
        if [ -z "$CRATE_PATH" ] || [ ! -d "$CRATE_PATH" ]; then
            error "Crate path not found: $CRATE_PATH"
            return 1
        fi
        info "Adding ${PROJECT_NAME}-core from local path..."
        echo "${PROJECT_NAME}-core = { path = \"$CRATE_PATH\" }" >> Cargo.toml
    fi
    
    # Add required dependencies
    echo 'serde_json = "1.0"' >> Cargo.toml
    
    # Create test program
    cat > src/main.rs << EOF
use ${PROJECT_NAME//-/_}_core;
use serde_json::json;

fn main() {
    // Test 1: Basic diff function
    let v1 = json!({"test": "value1", "number": 42});
    let v2 = json!({"test": "value2", "number": 43});
    
    let result = ${PROJECT_NAME//-/_}_core::diff_basic(&v1, &v2);
    println!("Basic diff found {} differences", result.len());
    assert!(!result.is_empty(), "Should find differences");
    
    // Test 2: Enhanced diff function (if available)
    let result2 = ${PROJECT_NAME//-/_}_core::diff(&v1, &v2, None, None, None);
    println!("Enhanced diff found {} differences", result2.len());
    assert!(!result2.is_empty(), "Should find differences");
    
    // Test 3: Same values should have no differences
    let result3 = ${PROJECT_NAME//-/_}_core::diff_basic(&v1, &v1);
    println!("Same values diff found {} differences", result3.len());
    assert!(result3.is_empty(), "Should find no differences for same values");
    
    println!("All crate function tests passed!");
}
EOF
    
    # Test 1: Check if crate builds
    run_test "Crate builds successfully" "cargo check"
    
    # Test 2: Run the test program
    run_test "Crate functions work correctly" "cargo run"
    
    # Test 3: Run cargo test on the crate itself (for local only)
    if ! is_published_test "$SOURCE_TYPE"; then
        info "Running cargo test on the crate..."
        cd "$CRATE_PATH/.."
        run_test "Cargo test passes" "cargo test --workspace"
        cd "$test_dir"
    fi
    
    # Test 4: Check documentation builds
    run_test "Documentation builds" "cargo doc --no-deps"
    
    # Test 5: Clippy check
    if command -v clippy &> /dev/null; then
        run_test "Clippy check passes" "cargo clippy -- -D warnings"
    else
        warning "Clippy not available, skipping linting check"
    fi
    
    cd "$PROJECT_ROOT"
    
    print_test_summary
}

# Run tests
test_rust_crate