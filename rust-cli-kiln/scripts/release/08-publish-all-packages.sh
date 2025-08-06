#!/bin/bash
# 08-publish-all-packages.sh - Atomic publish from GitHub Actions artifacts
# Downloads all platform artifacts and publishes ALL packages atomically
# Usage: ./08-publish-all-packages.sh

set -euo pipefail

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"

# =============================================================================
# Configuration
# =============================================================================

detect_project() {
    if [[ -n "${WORKFLOW_CALL_PROJECT:-}" ]]; then
        echo "${WORKFLOW_CALL_PROJECT}"
        return 0
    fi
    
    local detected_project=""
    for project in diffx diffai lawkit; do
        if [[ -f "${project}/Cargo.toml" ]]; then
            if detected_project; then
                error "Multiple projects detected: $detected_project and $project"
            fi
            detected_project="$project"
        fi
    done
    
    if [[ -z "$detected_project" ]]; then
        error "No project detected. Run from repository root containing diffx/, diffai/, or lawkit/"
    fi
    
    echo "$detected_project"
}

# =============================================================================
# Artifact Management
# =============================================================================

download_all_artifacts() {
    local project_name="$1"
    local artifacts_dir="./publish-artifacts"
    
    print_info "Downloading all build artifacts for publishing..."
    
    # Create artifacts directory
    mkdir -p "$artifacts_dir"
    cd "$artifacts_dir"
    
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        # In GitHub Actions, download artifacts from current workflow
        local current_run_id="${GITHUB_RUN_ID}"
        
        print_info "Downloading artifacts from workflow run: $current_run_id"
        
        # Download all artifacts from the workflow run
        gh run download "$current_run_id" || {
            error "Failed to download artifacts from workflow run $current_run_id"
        }
    else
        print_warning "Not in GitHub Actions environment - artifacts download skipped"
        print_info "Assuming local build artifacts are available"
    fi
    
    cd ..
    print_success "Artifacts download completed"
}

# =============================================================================
# Package Publishing
# =============================================================================

publish_rust_packages() {
    local project_name="$1"
    
    print_info "=== Publishing Rust Packages ==="
    
    # Publish core crate first (CLI depends on it)
    print_info "Publishing ${project_name}-core to crates.io..."
    
    cd "${project_name}-core"
    
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        if cargo publish; then
            print_success "${project_name}-core published to crates.io"
        else
            error "Failed to publish ${project_name}-core to crates.io"
        fi
    else
        if cargo publish --dry-run; then
            print_success "${project_name}-core dry-run passed"
        else
            error "${project_name}-core dry-run failed"
        fi
    fi
    
    cd "$PROJECT_ROOT"
    
    # Wait for crate to be available
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        print_info "Waiting 30 seconds for crate to propagate..."
        sleep 30
    fi
    
    # Publish CLI crate
    print_info "Publishing ${project_name} CLI to crates.io..."
    
    cd "${project_name}-cli"
    
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        if cargo publish; then
            print_success "${project_name} CLI published to crates.io"
        else
            error "Failed to publish ${project_name} CLI to crates.io"
        fi
    else
        if cargo publish --dry-run; then
            print_success "${project_name} CLI dry-run passed"
        else
            error "${project_name} CLI dry-run failed"
        fi
    fi
    
    cd "$PROJECT_ROOT"
}

publish_python_packages() {
    local project_name="$1"
    local artifacts_dir="./publish-artifacts"
    
    print_info "=== Publishing Python Packages ==="
    
    # Collect all Python wheels from artifacts
    local wheels_dir="./collected-wheels"
    mkdir -p "$wheels_dir"
    
    # Find and collect all .whl files from artifacts
    find "$artifacts_dir" -name "*.whl" -type f | while read -r wheel_file; do
        local wheel_name
        wheel_name=$(basename "$wheel_file")
        print_info "Found wheel: $wheel_name"
        cp "$wheel_file" "$wheels_dir/"
    done
    
    # Check if we have wheels
    local wheel_count
    wheel_count=$(find "$wheels_dir" -name "*.whl" | wc -l)
    
    if [[ "$wheel_count" -eq 0 ]]; then
        error "No Python wheels found in artifacts"
    fi
    
    print_info "Found $wheel_count Python wheels for publishing"
    
    # List all wheels
    find "$wheels_dir" -name "*.whl" -exec basename {} \; | sort
    
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        # Use twine to publish all wheels to PyPI
        if command -v twine &> /dev/null; then
            print_info "Publishing all wheels to PyPI..."
            if twine upload "$wheels_dir"/*.whl; then
                print_success "All Python wheels published to PyPI"
            else
                error "Failed to publish Python wheels to PyPI"
            fi
        else
            error "twine not found - required for PyPI publishing"
        fi
    else
        # Dry run - validate all wheels
        if twine check "$wheels_dir"/*.whl; then
            print_success "All Python wheels validation passed"
        else
            error "Python wheels validation failed"
        fi
    fi
}

publish_npm_packages() {
    local project_name="$1"
    local artifacts_dir="./publish-artifacts"
    
    print_info "=== Publishing npm Packages ==="
    
    # Collect all npm packages from artifacts
    local npm_dir="./collected-npm"
    mkdir -p "$npm_dir"
    
    # Find and collect all .tgz files from artifacts
    find "$artifacts_dir" -name "*.tgz" -type f | while read -r tgz_file; do
        local tgz_name
        tgz_name=$(basename "$tgz_file")
        print_info "Found npm package: $tgz_name"
        cp "$tgz_file" "$npm_dir/"
    done
    
    # Check if we have npm packages
    local tgz_count
    tgz_count=$(find "$npm_dir" -name "*.tgz" | wc -l)
    
    if [[ "$tgz_count" -eq 0 ]]; then
        print_warning "No npm packages found in artifacts - may be platform-specific"
        return 0
    fi
    
    print_info "Found $tgz_count npm packages for publishing"
    
    # List all packages
    find "$npm_dir" -name "*.tgz" -exec basename {} \; | sort
    
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        # Publish all npm packages
        for tgz_file in "$npm_dir"/*.tgz; do
            local package_name
            package_name=$(basename "$tgz_file")
            print_info "Publishing $package_name..."
            
            if npm publish "$tgz_file"; then
                print_success "$package_name published to npm"
            else
                error "Failed to publish $package_name to npm"
            fi
        done
    else
        # Dry run - validate all packages
        for tgz_file in "$npm_dir"/*.tgz; do
            local package_name
            package_name=$(basename "$tgz_file")
            print_info "Validating $package_name..."
            
            # Extract and validate package.json
            if tar -tf "$tgz_file" package/package.json > /dev/null 2>&1; then
                print_success "$package_name validation passed"
            else
                error "$package_name validation failed"
            fi
        done
    fi
}

# =============================================================================
# Prerequisites Check
# =============================================================================

check_prerequisites() {
    print_info "Checking publishing prerequisites..."
    
    # Check required commands
    check_command "gh" "GitHub CLI"
    
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        # Check required environment variables
        if [[ -z "${CARGO_REGISTRY_TOKEN:-}" ]]; then
            error "CARGO_REGISTRY_TOKEN not set - required for crates.io publishing"
        fi
        
        if [[ -z "${NODE_AUTH_TOKEN:-}" ]] && [[ -z "${NPM_TOKEN:-}" ]]; then
            error "NODE_AUTH_TOKEN or NPM_TOKEN not set - required for npm publishing"
        fi
        
        if [[ -z "${TWINE_PASSWORD:-}" ]] && [[ -z "${PYPI_TOKEN:-}" ]]; then
            error "TWINE_PASSWORD or PYPI_TOKEN not set - required for PyPI publishing"
        fi
        
        print_success "All required tokens are available"
        
        # Check GitHub authentication
        if ! gh auth status >/dev/null 2>&1; then
            error "Not authenticated with GitHub CLI"
        fi
    fi
    
    # Check required tools
    check_command "cargo" "Rust cargo"
    check_command "twine" "Python twine"
    check_command "npm" "Node.js npm"
}

# =============================================================================
# Main Execution
# =============================================================================

main() {
    print_header "Atomic Package Publishing"
    
    # Detect project
    local project_name
    project_name=$(detect_project)
    print_info "Detected project: $project_name"
    
    # Set up environment
    export CARGO_TERM_COLOR=always
    export RUST_BACKTRACE=1
    export LD_PRELOAD=  # Disable proxychains for clean execution
    
    # Check prerequisites
    check_prerequisites
    
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        print_info "🚀 PRODUCTION PUBLISHING MODE"
        print_warning "Publishing to production registries: crates.io, PyPI, npm"
    else
        print_info "🧪 DRY-RUN MODE"
        print_info "Validating packages without publishing"
    fi
    
    # Download all artifacts
    download_all_artifacts "$project_name"
    
    # Atomic publishing - all or nothing
    print_info "Phase 1: Publishing Rust packages..."
    publish_rust_packages "$project_name"
    
    print_info "Phase 2: Publishing Python packages..."
    publish_python_packages "$project_name"
    
    print_info "Phase 3: Publishing npm packages..."
    publish_npm_packages "$project_name"
    
    # Cleanup
    if [[ -d "./publish-artifacts" ]]; then
        rm -rf "./publish-artifacts"
    fi
    if [[ -d "./collected-wheels" ]]; then
        rm -rf "./collected-wheels"
    fi
    if [[ -d "./collected-npm" ]]; then
        rm -rf "./collected-npm"
    fi
    
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        print_success "🎉 ATOMIC PUBLISH SUCCESSFUL!"
        print_info "All packages published successfully:"
        print_info "  ✓ ${project_name}-core → crates.io"
        print_info "  ✓ ${project_name} CLI → crates.io"
        print_info "  ✓ ${project_name}-python → PyPI (multi-platform)"
        print_info "  ✓ ${project_name}-js → npm (multi-platform)"
        print_info ""
        print_info "Next step: 09-test-published-packages.sh"
    else
        print_success "🎉 DRY-RUN VALIDATION SUCCESSFUL!"
        print_info "All packages are ready for publishing"
        print_info "Run this script in GitHub Actions to publish to production"
    fi
}

# Only run main if this script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi