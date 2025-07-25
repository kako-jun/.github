#!/bin/bash
set -euo pipefail

# Atomic Publish Script - AI Optimized
# Publishes ALL packages atomically after successful build/test
# NO INTERACTIVE INPUT - Fully automated for AI execution

# Disable proxychains for clean execution
export LD_PRELOAD=

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"

# Initialize project variables
init_project_vars

print_script_header "Atomic Publish Script" "全パッケージのアトミック公開 - 部分失敗を防止"

# GitHub Actions environment simulation
export CARGO_TERM_COLOR=always
export RUST_BACKTRACE=1

echo "🚨 CRITICAL: This script publishes to production registries"
echo "   - crates.io (Rust CLI & core)"
echo "   - npmjs.com (npm package)" 
echo "   - PyPI (Python package)"
echo "   ALL must succeed or ALL will fail"
echo ""

if ! is_github_actions; then
    echo "⚠️  LOCAL MODE: Will only run dry-run checks (no actual publishing)"
    echo ""
fi

check_prerequisites() {
    info "Checking publishing prerequisites..."
    
    # Check required environment variables for GitHub Actions
    if is_github_actions; then
        if [[ -z "${CARGO_REGISTRY_TOKEN:-}" ]]; then
            error "CARGO_REGISTRY_TOKEN not set - required for crates.io publishing"
            exit 1
        fi
        
        if [[ -z "${NPM_TOKEN:-}" ]] && [[ -z "${NODE_AUTH_TOKEN:-}" ]]; then
            error "NPM_TOKEN or NODE_AUTH_TOKEN not set - required for npm publishing"
            exit 1
        fi
        
        if [[ -z "${PYPI_TOKEN:-}" ]] && [[ -z "${TWINE_PASSWORD:-}" ]]; then
            error "PYPI_TOKEN or TWINE_PASSWORD not set - required for PyPI publishing"
            exit 1
        fi
        
        success "✓ All required tokens are available"
    fi
    
    # Check that build artifacts exist (from 05-build-and-test.sh)
    if [[ ! -f "target/release/${PROJECT_NAME}" ]]; then
        error "Release binary not found - run 05-build-and-test.sh first"
        exit 1
    fi
    
    if [[ ! -d "${PROJECT_NAME}-python/dist" ]] || [[ -z "$(ls -A ${PROJECT_NAME}-python/dist 2>/dev/null)" ]]; then
        error "Python wheel not found - run 05-build-and-test.sh first"
        exit 1
    fi
    
    success "✓ Required build artifacts are present"
}

publish_rust_packages() {
    info "=== Publishing Rust Packages ==="
    
    # Publish core crate first (CLI depends on it)
    info "Publishing ${PROJECT_NAME}-core to crates.io..."
    cd "${PROJECT_NAME}-core"
    
    if is_github_actions; then
        if cargo publish; then
            success "✓ ${PROJECT_NAME}-core published to crates.io"
        else
            error "Failed to publish ${PROJECT_NAME}-core to crates.io"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    else
        if cargo publish --dry-run; then
            success "✓ ${PROJECT_NAME}-core dry-run passed"
        else
            error "${PROJECT_NAME}-core dry-run failed"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
    
    # Wait for crate to be available
    if is_github_actions; then
        info "Waiting 30 seconds for crate to propagate..."
        sleep 30
    fi
    
    # Publish CLI crate
    info "Publishing ${PROJECT_NAME} CLI to crates.io..."
    cd "${PROJECT_NAME}-cli"
    
    if is_github_actions; then
        if cargo publish; then
            success "✓ ${PROJECT_NAME} CLI published to crates.io"
        else
            error "Failed to publish ${PROJECT_NAME} CLI to crates.io"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    else
        if cargo publish --dry-run; then
            success "✓ ${PROJECT_NAME} CLI dry-run passed"
        else
            error "${PROJECT_NAME} CLI dry-run failed"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
}

publish_npm_package() {
    info "=== Publishing npm Package ==="
    
    cd "${PROJECT_NAME}-js"
    
    if is_github_actions; then
        if npm publish; then
            success "✓ npm package published"
        else
            error "Failed to publish npm package"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    else
        if npm publish --dry-run; then
            success "✓ npm package dry-run passed"
        else
            error "npm package dry-run failed"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
}

publish_python_package() {
    info "=== Publishing Python Package ==="
    
    cd "${PROJECT_NAME}-python"
    
    if is_github_actions; then
        # Use twine to publish to PyPI
        if command -v twine &> /dev/null; then
            if twine upload dist/*.whl; then
                success "✓ Python package published to PyPI"
            else
                error "Failed to publish Python package to PyPI"
                cd "$PROJECT_ROOT"
                exit 1
            fi
        else
            error "twine not found - required for PyPI publishing"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    else
        if twine check dist/*.whl; then
            success "✓ Python package validation passed"
        else
            error "Python package validation failed"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
}

main() {
    # Prerequisites check
    check_prerequisites
    
    if is_github_actions; then
        info "🚀 PRODUCTION PUBLISHING MODE"
        info "Publishing to production registries..."
    else
        info "🧪 DRY-RUN MODE" 
        info "Validating packages without publishing..."
    fi
    
    echo ""
    
    # Atomic publishing - all or nothing
    info "Phase 1: Publishing Rust packages..."
    publish_rust_packages
    
    info "Phase 2: Publishing npm package..."
    publish_npm_package
    
    info "Phase 3: Publishing Python package..."
    publish_python_package
    
    echo ""
    if is_github_actions; then
        success "🎉 ATOMIC PUBLISH SUCCESSFUL!"
        info "All packages published successfully:"
        info "  ✓ ${PROJECT_NAME}-core → crates.io"
        info "  ✓ ${PROJECT_NAME} CLI → crates.io" 
        info "  ✓ ${PROJECT_NAME}-js → npmjs.com"
        info "  ✓ ${PROJECT_NAME}-python → PyPI"
        info ""
        info "Next step: 07-create-release-tag.sh to create GitHub release"
    else
        success "🎉 DRY-RUN VALIDATION SUCCESSFUL!"
        info "All packages are ready for publishing"
        info "Run this script in GitHub Actions to publish to production"
    fi
}

# Run main function
main "$@"