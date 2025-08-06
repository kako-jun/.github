#!/bin/bash
set -euo pipefail

# Create git tag and push for release - AI Optimized
# This script only handles tag creation and pushing, nothing else
# NO INTERACTIVE INPUT - Fully automated for AI execution

# Disable proxychains for clean execution
export LD_PRELOAD=

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"

# Initialize project variables
init_project_vars

print_script_header "Release Tag Creation" "Gitタグ作成・プッシュによるリリーストリガー"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Configuration
MAIN_BRANCH="main"
CURRENT_BRANCH=$(git branch --show-current)

# Function to check if we're on the main branch
check_branch() {
    if [ "$CURRENT_BRANCH" != "$MAIN_BRANCH" ]; then
        print_error "You must be on the $MAIN_BRANCH branch to create release tag"
        exit 1
    fi
}

# Function to check if working directory is clean
check_git_status() {
    if ! git diff-index --quiet HEAD --; then
        print_error "Working directory is not clean. Please commit or stash your changes."
        exit 1
    fi
}

# Function to get current version
get_current_version() {
    grep -E '^version = ".*"' "$PROJECT_ROOT/Cargo.toml" | head -1 | sed 's/version = "\(.*\)"/\1/'
}

# Function to create git tag and push
create_and_push_tag() {
    local version=$1
    local tag="v$version"
    
    print_info "Creating git tag $tag"
    
    # Commit version updates (if any uncommitted changes)
    if ! git diff-index --quiet HEAD --; then
        git add -A
        git commit -m "chore: release version $version"
    fi
    
    # Create tag
    git tag -a "$tag" -m "Release $tag"
    
    # Push changes and tag
    print_info "Pushing changes and tag to remote"
    git push origin "$MAIN_BRANCH"
    git push origin "$tag"
    
    print_success "Tag $tag created and pushed!"
    print_info "GitHub Actions will now start building and publishing packages"
    print_info "Monitor progress at: $(git remote get-url origin | sed 's/\.git$//')/actions"
}

# Main function
main() {
    print_info "Creating release tag for ${PROJECT_NAME}"
    
    # Pre-flight checks
    check_branch
    check_git_status
    
    # Get current version from Cargo.toml
    CURRENT_VERSION=$(get_current_version)
    print_info "Current version: $CURRENT_VERSION"
    
    # Create and push tag
    create_and_push_tag "$CURRENT_VERSION"
    
    print_success "Release tag created successfully!"
    echo ""
    print_info "Next steps:"
    echo "  1. Monitor GitHub Actions: ./github-shared/rust-cli-kiln/scripts/release/07-monitor-build-actions.sh v$CURRENT_VERSION"
    echo "  2. Or check manually: $(git remote get-url origin | sed 's/\.git$//')/actions"
}

# Run main function
main "$@"