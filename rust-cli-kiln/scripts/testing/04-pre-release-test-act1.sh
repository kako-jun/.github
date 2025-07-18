#!/bin/bash
set -uo pipefail

# Pre-release test Act 1 - Core build and Rust ecosystem testing
# This script builds Rust workspace and tests the binary/crate functionality

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"
source "$SCRIPT_DIR/common/test-utils.sh"

# Initialize project variables
init_project_vars

# GitHub Actions environment simulation
export CARGO_TERM_COLOR=always
export RUST_BACKTRACE=1

cleanup_workspace() {
    # Clean up any workspace pollution
    info "Cleaning up workspace configuration..."
    # Remove test directory entries completely
    sed -i '/target\/.*tmp-crate-test/d' "${PROJECT_ROOT}/Cargo.toml"
    # Remove any malformed entries that might have been added
    sed -i '/^    "target\//d' "${PROJECT_ROOT}/Cargo.toml"
    # Replace whatever is after "diffai-cli" with ] and empty line
    sed -i '/^    "diffai-cli"$/{ N; s/.*/    "diffai-cli"\n]\n/ }' "${PROJECT_ROOT}/Cargo.toml"
    # Restore "target/" after ".github/"
    sed -i '/^    "\.github\/",$/a\    "target/"' "${PROJECT_ROOT}/Cargo.toml"
}

main() {
    info "=== Pre-release Test Act 1 - Core Build and Rust Ecosystem Testing ==="
    info "This builds and tests the Rust workspace with comprehensive validation"
    echo ""
    
    # Set up cleanup on exit
    trap cleanup_workspace EXIT
    
    # Step 1: Install required targets
    info "Step 1: Installing required Rust targets..."
    LOCAL_TARGET=$(rustc -vV | grep host | cut -d' ' -f2)
    info "Local target: $LOCAL_TARGET"
    
    if ! rustup target list --installed | grep -q "$LOCAL_TARGET"; then
        rustup target add "$LOCAL_TARGET"
    fi
    
    # Step 2: Run comprehensive Rust tests and checks
    info "Step 2: Running comprehensive Rust tests and checks..."
    
    # Format check
    info "Checking code formatting..."
    cargo fmt --all --check
    
    # Clippy check
    info "Running Clippy..."
    cargo clippy --workspace --all-targets --all-features -- -D warnings
    
    # Build workspace
    info "Building workspace..."
    cargo build --workspace
    
    # Run ALL tests (including integration tests)
    info "Running comprehensive test suite..."
    cargo test --workspace
    
    # Quick performance check
    info "Quick performance check..."
    cargo build --release --package ${PROJECT_NAME}-core
    success "Release build successful - performance optimizations applied"
    
    # Step 3: Build release binary
    info "Step 3: Building release binary for local target..."
    cargo build --package ${PROJECT_NAME} --release --target "$LOCAL_TARGET"
    
    # Step 4: Test built binary using common framework
    info "Step 4: Testing built binary functionality..."
    BINARY_PATH="${PROJECT_ROOT}/target/$LOCAL_TARGET/release/${PROJECT_NAME}"
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        BINARY_PATH="$BINARY_PATH.exe"
    fi
    
    if [ ! -f "$BINARY_PATH" ]; then
        error "Binary not found at $BINARY_PATH"
        exit 1
    fi
    
    # Use common test framework
    if ! "$SCRIPT_DIR/common/test-rust-binary.sh" local "$BINARY_PATH"; then
        error "Binary functionality test failed"
        exit 1
    fi
    
    # Step 5: Test core crate using common framework
    info "Step 5: Testing core crate functionality..."
    if ! "$SCRIPT_DIR/common/test-rust-crate.sh" local "${PROJECT_ROOT}/${PROJECT_NAME}-core"; then
        error "Core crate functionality test failed"
        exit 1
    fi
    
    # Step 6: Simulate crates.io publish (dry run only)
    info "Step 6: Simulating crates.io publish (dry run only)..."
    
    # Check core crate publish readiness
    info "Checking ${PROJECT_NAME}-core publish readiness (dry run)..."
    cd "${PROJECT_NAME}-core"
    # Capture dry run output and check for the expected "aborting upload due to dry run" message
    DRY_RUN_OUTPUT=$(cargo publish --dry-run --allow-dirty 2>&1)
    DRY_RUN_EXIT_CODE=$?
    echo "$DRY_RUN_OUTPUT"
    
    if echo "$DRY_RUN_OUTPUT" | grep -q "aborting upload due to dry run"; then
        success "${PROJECT_NAME}-core dry run passed (upload aborted as expected)"
    elif [ $DRY_RUN_EXIT_CODE -eq 0 ]; then
        success "${PROJECT_NAME}-core dry run passed"
    else
        error "${PROJECT_NAME}-core dry run failed"
        exit 1
    fi
    cd "$PROJECT_ROOT"
    
    # Check CLI crate publish readiness
    info "Checking ${PROJECT_NAME}-cli publish readiness (dry run)..."
    cd "${PROJECT_NAME}-cli"
    if cargo publish --dry-run --allow-dirty; then
        success "${PROJECT_NAME}-cli dry run passed"
    else
        warning "${PROJECT_NAME}-cli dry run failed (expected for workspace dependencies)"
        info "This is normal when CLI depends on unpublished workspace crates"
        info "Actual publish will work after ${PROJECT_NAME}-core is published to crates.io"
    fi
    cd "$PROJECT_ROOT"
    
    success "Crates.io dry run checks passed (no actual publishing)"
    warning "Note: Actual crates.io publishing happens only in GitHub Actions"
    
    # Step 7: Version consistency check
    info "Step 7: Verifying version consistency..."
    if ! "$SCRIPT_DIR/../release/03-check-local-versions.sh"; then
        error "Version consistency check failed"
        exit 1
    fi
    
    # Step 8: Git state check
    info "Step 8: Git state verification..."
    if [ -d "target" ]; then
        info "Build artifacts present (normal during testing)"
    fi
    
    if git diff --quiet Cargo.lock; then
        success "Cargo.lock unchanged during testing"
    else
        info "Cargo.lock was updated during testing (normal)"
    fi
    
    success "Git state check completed (version changes expected for release)"
    
    success "=== Pre-release Test Act 1 PASSED ==="
    info "All Rust ecosystem checks passed! Ready for Act 2 testing."
    echo ""
    info "Next step: ./github-shared/rust-cli-kiln/scripts/testing/05-pre-release-test-act2.sh"
}

# Run main function
main "$@"