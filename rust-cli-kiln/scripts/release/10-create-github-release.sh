#!/bin/bash
# 10-create-github-release.sh - Create GitHub release page with binary assets
# Usage: ./10-create-github-release.sh

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

download_artifacts() {
    local project_name="$1"
    local tag_name="$2"
    local artifacts_dir="./release-artifacts"
    
    print_info "Downloading release artifacts for $project_name $tag_name..."
    
    # Create artifacts directory
    mkdir -p "$artifacts_dir"
    cd "$artifacts_dir"
    
    # Get the latest workflow run for the tag
    local workflow_run_id
    workflow_run_id=$(gh run list \
        --workflow="release.yml" \
        --branch="$tag_name" \
        --limit=1 \
        --json=databaseId \
        --jq='.[0].databaseId')
    
    if [[ -z "$workflow_run_id" ]]; then
        error "No workflow run found for tag $tag_name"
    fi
    
    print_info "Found workflow run ID: $workflow_run_id"
    
    # Download all artifacts from the workflow run
    gh run download "$workflow_run_id" || {
        error "Failed to download artifacts from workflow run $workflow_run_id"
    }
    
    cd ..
    print_success "Downloaded artifacts to $artifacts_dir"
}

# =============================================================================
# Binary Packaging
# =============================================================================

package_binaries() {
    local project_name="$1"
    local artifacts_dir="./release-artifacts"
    local packages_dir="./release-packages"
    
    print_info "Packaging binaries for distribution..."
    
    mkdir -p "$packages_dir"
    
    # Package each platform's binary
    for target_dir in "$artifacts_dir"/$project_name-*; do
        if [[ ! -d "$target_dir" ]]; then
            continue
        fi
        
        local target_name
        target_name=$(basename "$target_dir" | sed "s/^$project_name-//")
        
        # Skip non-binary artifacts
        if [[ "$target_name" == "python-wheels" ]] || [[ "$target_name" == "npm-package" ]]; then
            continue
        fi
        
        local platform_name
        case "$target_name" in
            "x86_64-unknown-linux-gnu")
                platform_name="linux-x64"
                ;;
            "aarch64-unknown-linux-gnu")
                platform_name="linux-arm64"
                ;;
            "x86_64-apple-darwin")
                platform_name="darwin-x64"
                ;;
            "aarch64-apple-darwin")
                platform_name="darwin-arm64"
                ;;
            "x86_64-pc-windows-msvc")
                platform_name="win32-x64"
                ;;
            "aarch64-pc-windows-msvc")
                platform_name="win32-arm64"
                ;;
            *)
                print_warning "Unknown target: $target_name, skipping..."
                continue
                ;;
        esac
        
        local binary_name="$project_name"
        if [[ "$target_name" == *"windows"* ]]; then
            binary_name="${project_name}.exe"
        fi
        
        # Find the binary in the target directory
        local binary_path
        if [[ -f "$target_dir/$binary_name" ]]; then
            binary_path="$target_dir/$binary_name"
        else
            # Look for any executable file
            binary_path=$(find "$target_dir" -type f -executable -name "$project_name*" | head -1)
            if [[ -z "$binary_path" ]]; then
                print_warning "No binary found in $target_dir, skipping..."
                continue
            fi
        fi
        
        local package_name="${project_name}-${platform_name}.zip"
        local package_path="$packages_dir/$package_name"
        
        print_info "Creating package: $package_name"
        
        # Create zip package
        (cd "$(dirname "$binary_path")" && zip -r "../$package_path" "$(basename "$binary_path")")
        
        print_success "Created $package_name"
    done
}

# =============================================================================
# Release Creation
# =============================================================================

generate_release_notes() {
    local project_name="$1"
    local tag_name="$2"
    
    print_info "Generating release notes for $tag_name..."
    
    # Get previous tag
    local previous_tag
    previous_tag=$(git describe --tags --abbrev=0 "$tag_name^" 2>/dev/null || echo "")
    
    local release_notes="# Release $tag_name\n\n"
    
    if [[ -n "$previous_tag" ]]; then
        release_notes+="## Changes since $previous_tag\n\n"
        
        # Get commit messages since previous tag
        local commits
        commits=$(git log "$previous_tag..$tag_name" --oneline --no-merges | head -20)
        
        if [[ -n "$commits" ]]; then
            while IFS= read -r commit; do
                # Format commit message
                local commit_msg
                commit_msg=$(echo "$commit" | sed 's/^[a-f0-9]* /- /')
                release_notes+="$commit_msg\n"
            done <<< "$commits"
        else
            release_notes+="- No significant changes\n"
        fi
    else
        release_notes+="## Initial release\n\n"
        release_notes+="- First stable release of $project_name\n"
    fi
    
    release_notes+="\n## Installation\n\n"
    release_notes+="### Rust (via cargo)\n"
    release_notes+="\`\`\`bash\n"
    release_notes+="cargo install $project_name\n"
    release_notes+="\`\`\`\n\n"
    
    release_notes+="### Python (via pip)\n"
    release_notes+="\`\`\`bash\n"
    release_notes+="pip install $project_name\n"
    release_notes+="\`\`\`\n\n"
    
    release_notes+="### Node.js (via npm)\n"
    release_notes+="\`\`\`bash\n"
    release_notes+="npm install -g $project_name\n"
    release_notes+="\`\`\`\n\n"
    
    release_notes+="### Binary Downloads\n"
    release_notes+="Download pre-compiled binaries from the assets below.\n\n"
    
    release_notes+="---\n\n"
    release_notes+="🤖 Generated with [Claude Code](https://claude.ai/code)\n\n"
    release_notes+="Co-Authored-By: Claude <noreply@anthropic.com>\n"
    
    echo -e "$release_notes"
}

create_github_release() {
    local project_name="$1"
    local tag_name="$2"
    local packages_dir="./release-packages"
    
    print_info "Creating GitHub release for $tag_name..."
    
    # Check if release already exists
    if gh release view "$tag_name" >/dev/null 2>&1; then
        print_warning "Release $tag_name already exists, updating..."
        local release_exists=true
    else
        local release_exists=false
    fi
    
    # Generate release notes
    local release_notes
    release_notes=$(generate_release_notes "$project_name" "$tag_name")
    
    if [[ "$release_exists" == "true" ]]; then
        # Update existing release
        gh release edit "$tag_name" --title "Release $tag_name" --notes "$release_notes"
    else
        # Create new release
        gh release create "$tag_name" \
            --title "Release $tag_name" \
            --notes "$release_notes" \
            --verify-tag
    fi
    
    # Upload binary assets
    if [[ -d "$packages_dir" ]] && [[ -n "$(ls -A "$packages_dir" 2>/dev/null)" ]]; then
        print_info "Uploading binary assets..."
        
        for package in "$packages_dir"/*.zip; do
            if [[ -f "$package" ]]; then
                local package_name
                package_name=$(basename "$package")
                print_info "Uploading $package_name..."
                
                # Remove existing asset if it exists
                gh release delete-asset "$tag_name" "$package_name" --yes 2>/dev/null || true
                
                # Upload new asset
                gh release upload "$tag_name" "$package" --clobber
                print_success "Uploaded $package_name"
            fi
        done
    else
        print_warning "No binary packages found to upload"
    fi
    
    print_success "GitHub release created successfully!"
    print_info "View at: https://github.com/kako-jun/$project_name/releases/tag/$tag_name"
}

# =============================================================================
# Main Execution
# =============================================================================

main() {
    print_header "GitHub Release Creation"
    
    # Detect project
    local project_name
    project_name=$(detect_project)
    print_info "Detected project: $project_name"
    
    # Get current tag
    local current_tag
    current_tag=$(git describe --tags --exact-match HEAD 2>/dev/null) || {
        error "Current HEAD is not tagged. Run this script after creating a release tag."
    }
    print_info "Current tag: $current_tag"
    
    # Verify prerequisites
    check_command "gh" "GitHub CLI"
    check_command "zip" "zip utility"
    
    # Verify GitHub authentication
    if ! gh auth status >/dev/null 2>&1; then
        error "Not authenticated with GitHub CLI. Run 'gh auth login' first."
    fi
    
    # Check if we're in GitHub Actions environment
    if [[ "${GITHUB_ACTIONS:-false}" == "true" ]]; then
        print_info "Running in GitHub Actions environment"
        
        # Download artifacts from the current workflow run
        download_artifacts "$project_name" "$current_tag"
        
        # Package binaries for distribution
        package_binaries "$project_name"
    else
        print_warning "Not running in GitHub Actions. Binary packaging skipped."
        print_info "Release will be created without binary assets."
    fi
    
    # Create GitHub release
    create_github_release "$project_name" "$current_tag"
    
    # Cleanup
    if [[ -d "./release-artifacts" ]]; then
        rm -rf "./release-artifacts"
    fi
    if [[ -d "./release-packages" ]]; then
        rm -rf "./release-packages"
    fi
    
    print_success "Release creation completed successfully!"
}

# Only run main if this script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi