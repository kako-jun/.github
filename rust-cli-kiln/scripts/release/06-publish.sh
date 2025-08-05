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
    echo "📋 Checking publishing prerequisites..."
    
    # Check required environment variables for GitHub Actions
    if is_github_actions; then
        if [[ -z "${CARGO_REGISTRY_TOKEN:-}" ]]; then
            echo "❌ ERROR: CARGO_REGISTRY_TOKEN not set - required for crates.io publishing"
            exit 1
        fi
        
        if [[ -z "${NPM_TOKEN:-}" ]] && [[ -z "${NODE_AUTH_TOKEN:-}" ]]; then
            echo "❌ ERROR: NPM_TOKEN or NODE_AUTH_TOKEN not set - required for npm publishing"
            exit 1
        fi
        
        if [[ -z "${PYPI_TOKEN:-}" ]] && [[ -z "${TWINE_PASSWORD:-}" ]]; then
            echo "❌ ERROR: PYPI_TOKEN or TWINE_PASSWORD not set - required for PyPI publishing"
            exit 1
        fi
        
        echo "✅ All required tokens are available"
    fi
    
    # Check that build artifacts exist (from 05-build-and-test.sh)
    # 05-build-and-test.sh runs release build for core library
    if [[ ! -d "target/release" ]]; then
        echo "❌ ERROR: Release build directory not found - run 05-build-and-test.sh first"
        exit 1
    fi
    
    # Check for Python wheels (built by maturin to target/wheels/)
    if [[ ! -d "target/wheels" ]] || [[ -z "$(ls -A target/wheels/${PROJECT_NAME}*python*.whl 2>/dev/null)" ]]; then
        echo "❌ ERROR: Python wheel not found in target/wheels/ - run 05-build-and-test.sh first"
        exit 1
    fi
    
    echo "✅ Required build artifacts are present"
}

publish_rust_packages() {
    echo "📦 === Publishing Rust Packages ==="
    
    # Publish core crate first (CLI depends on it)
    echo "📦 Publishing ${PROJECT_NAME}-core to crates.io..."
    cd "${PROJECT_NAME}-core"
    
    if is_github_actions; then
        if cargo publish; then
            echo "✅ ${PROJECT_NAME}-core published to crates.io"
        else
            echo "❌ ERROR: Failed to publish ${PROJECT_NAME}-core to crates.io"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    else
        if cargo publish --dry-run; then
            echo "✅ ✓ ${PROJECT_NAME}-core dry-run passed"
        else
            echo "❌ ERROR: ${PROJECT_NAME}-core dry-run failed"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
    
    # Wait for crate to be available
    if is_github_actions; then
        echo "ℹ️  Waiting 30 seconds for crate to propagate..."
        sleep 30
    fi
    
    # Publish CLI crate
    echo "ℹ️  Publishing ${PROJECT_NAME} CLI to crates.io..."
    cd "${PROJECT_NAME}-cli"
    
    if is_github_actions; then
        if cargo publish; then
            echo "✅ ✓ ${PROJECT_NAME} CLI published to crates.io"
        else
            echo "❌ ERROR: Failed to publish ${PROJECT_NAME} CLI to crates.io"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    else
        if cargo publish --dry-run; then
            echo "✅ ✓ ${PROJECT_NAME} CLI dry-run passed"
        else
            echo "❌ ERROR: ${PROJECT_NAME} CLI dry-run failed"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
}

publish_npm_package() {
    echo "ℹ️  === Publishing npm Package ==="
    
    cd "${PROJECT_NAME}-js"
    
    if is_github_actions; then
        if npm publish; then
            echo "✅ ✓ npm package published"
        else
            echo "❌ ERROR: Failed to publish npm package"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    else
        if npm publish --dry-run; then
            echo "✅ ✓ npm package dry-run passed"
        else
            echo "❌ ERROR: npm package dry-run failed"
            cd "$PROJECT_ROOT"
            exit 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
}

publish_python_package() {
    echo "ℹ️  === Publishing Python Package ==="
    
    # Python wheels are in PROJECT_ROOT/target/wheels/ (built by maturin)
    if is_github_actions; then
        # Use twine to publish to PyPI
        if command -v twine &> /dev/null; then
            if twine upload target/wheels/${PROJECT_NAME}*python*.whl; then
                echo "✅ ✓ Python package published to PyPI"
            else
                echo "❌ ERROR: Failed to publish Python package to PyPI"
                exit 1
            fi
        else
            echo "❌ ERROR: twine not found - required for PyPI publishing"
            exit 1
        fi
    else
        if twine check target/wheels/${PROJECT_NAME}*python*.whl; then
            echo "✅ ✓ Python package validation passed"
        else
            echo "❌ ERROR: Python package validation failed"
            exit 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
}

main() {
    # Prerequisites check
    check_prerequisites
    
    if is_github_actions; then
        echo "ℹ️  🚀 PRODUCTION PUBLISHING MODE"
        echo "ℹ️  Publishing to production registries..."
    else
        echo "ℹ️  🧪 DRY-RUN MODE" 
        echo "ℹ️  Validating packages without publishing..."
    fi
    
    echo ""
    
    # Atomic publishing - all or nothing
    echo "ℹ️  Phase 1: Publishing Rust packages..."
    publish_rust_packages
    
    echo "ℹ️  Phase 2: Publishing npm package..."
    publish_npm_package
    
    echo "ℹ️  Phase 3: Publishing Python package..."
    publish_python_package
    
    echo ""
    if is_github_actions; then
        echo "✅ 🎉 ATOMIC PUBLISH SUCCESSFUL!"
        echo "ℹ️  All packages published successfully:"
        echo "ℹ️    ✓ ${PROJECT_NAME}-core → crates.io"
        echo "ℹ️    ✓ ${PROJECT_NAME} CLI → crates.io" 
        echo "ℹ️    ✓ ${PROJECT_NAME}-js → npmjs.com"
        echo "ℹ️    ✓ ${PROJECT_NAME}-python → PyPI"
        echo "ℹ️  "
        echo "ℹ️  Next step: 07-create-release-tag.sh to create GitHub release"
    else
        echo "✅ 🎉 DRY-RUN VALIDATION SUCCESSFUL!"
        echo "ℹ️  All packages are ready for publishing"
        echo "ℹ️  Run this script in GitHub Actions to publish to production"
    fi
}

# Run main function
main "$@"