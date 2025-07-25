#!/bin/bash

# Common utility functions for rust-cli-kiln scripts

# Function to find project root by looking for Cargo.toml
find_project_root() {
    local current_dir="$1"
    
    # Check if Cargo.toml exists in current directory
    if [ -f "$current_dir/Cargo.toml" ]; then
        echo "$current_dir"
        return 0
    fi
    
    # Check parent directories up to 5 levels
    for i in {1..5}; do
        current_dir="$(dirname "$current_dir")"
        if [ -f "$current_dir/Cargo.toml" ]; then
            echo "$current_dir"
            return 0
        fi
    done
    
    # If not found, fall back to script-relative path (for legacy compatibility)
    echo "$(cd "$SCRIPT_DIR/../.." && pwd)"
}

# Initialize project root and name
init_project_vars() {
    # If variables are already set by setup_github_actions_env, just cd to the correct directory
    if [ -n "${PROJECT_ROOT:-}" ] && [ -n "${PROJECT_NAME:-}" ]; then
        echo "Project variables already initialized by setup_github_actions_env"
        echo "  Project: $PROJECT_NAME"
        echo "  Project root: $PROJECT_ROOT"
        cd "$PROJECT_ROOT"
        return 0
    fi
    
    # Use the calling script's directory
    if [ -n "${BASH_SOURCE[1]:-}" ]; then
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)"
    else
        # Fallback for direct execution
        SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    fi
    
    # Determine project root
    if [ -f "./Cargo.toml" ]; then
        # Already in project root (GitHub Actions case)
        PROJECT_ROOT="$(pwd)"
    else
        # Find project root (local execution case)
        PROJECT_ROOT="$(find_project_root "$SCRIPT_DIR")"
    fi
    
    PROJECT_NAME=$(basename "$PROJECT_ROOT")
    
    # Change to project root
    cd "$PROJECT_ROOT"
    
    # Export variables for use in calling script
    export SCRIPT_DIR PROJECT_ROOT PROJECT_NAME
}

# Auto-detect project name for GitHub Actions workflows
detect_project_for_workflow() {
    local input_project="${1:-}"
    
    # Use provided project name if available
    if [ -n "$input_project" ]; then
        echo "$input_project"
        return 0
    fi
    
    # Auto-detect from repository name
    if [ -n "${GITHUB_REPOSITORY:-}" ]; then
        local repo_name=$(basename "$GITHUB_REPOSITORY")
        if [[ "$repo_name" =~ ^(diffx|diffai|lawkit)$ ]]; then
            echo "$repo_name"
            return 0
        fi
    fi
    
    # Try to detect from directory structure
    for project in diffx diffai lawkit; do
        if [ -d "../$project" ] && [ -f "../$project/Cargo.toml" ]; then
            echo "$project"
            return 0
        fi
    done
    
    # No project found
    return 1
}

# Setup unified environment for GitHub Actions workflows
# This ensures we have:
# 1. Project repository checked out
# 2. rust-cli-kiln available (via symlink or actual directory)
# 3. Current directory set to project root
setup_github_actions_env() {
    local project_name="${1:-}"
    
    # Detect project name if not provided
    if [ -z "$project_name" ]; then
        # For workflow_call
        if [ -n "${WORKFLOW_CALL_PROJECT:-}" ]; then
            project_name="$WORKFLOW_CALL_PROJECT"
        # For workflow_dispatch
        elif [ -n "${WORKFLOW_DISPATCH_PROJECT:-}" ]; then
            project_name="$WORKFLOW_DISPATCH_PROJECT"
        # Auto-detect
        else
            project_name=$(detect_project_for_workflow)
            if [ $? -ne 0 ]; then
                echo "Error: Could not determine project name"
                return 1
            fi
        fi
    fi
    
    echo "Setting up environment for project: $project_name"
    
    # Check if we're already in the project directory
    # For workspace projects, check if it contains the expected members
    if [ -f "Cargo.toml" ] && (
        grep -q "name = \"$project_name\"" Cargo.toml 2>/dev/null || \
        grep -q "\"$project_name-core\"" Cargo.toml 2>/dev/null || \
        grep -q "\"$project_name-cli\"" Cargo.toml 2>/dev/null
    ); then
        echo "Already in $project_name directory"
        
        # Ensure rust-cli-kiln is available
        if [ ! -d ".github/rust-cli-kiln" ]; then
            echo "Setting up rust-cli-kiln symlink..."
            # If we're in a workflow from .github repo, rust-cli-kiln should be available
            if [ -d "rust-cli-kiln" ]; then
                # We're in .github repo
                mkdir -p .github
                ln -s "$(pwd)/rust-cli-kiln" .github/rust-cli-kiln
            else
                # Clone .github repo to get rust-cli-kiln
                echo "Setting up .github repository for rust-cli-kiln..."
                if [ ! -d "/tmp/github-repo" ]; then
                    git clone https://github.com/kako-jun/.github.git /tmp/github-repo
                fi
                mkdir -p .github
                ln -s /tmp/github-repo/rust-cli-kiln .github/rust-cli-kiln
            fi
        fi
    else
        # We need to navigate to the project directory
        # This happens when workflow runs from .github repo
        echo "Navigating to project directory..."
        
        # Check if project exists as sibling directory
        if [ -d "../$project_name" ]; then
            cd "../$project_name"
        else
            echo "Error: Project directory not found"
            return 1
        fi
        
        # Setup rust-cli-kiln symlink
        if [ ! -d ".github/rust-cli-kiln" ]; then
            echo "Setting up rust-cli-kiln symlink..."
            # The .github repo should be in the parent directory
            if [ -d "../.github/rust-cli-kiln" ]; then
                mkdir -p .github
                ln -s "$(cd ../.. && pwd)/.github/rust-cli-kiln" .github/rust-cli-kiln
            else
                # Clone as fallback
                if [ ! -d "/tmp/github-repo" ]; then
                    git clone https://github.com/kako-jun/.github.git /tmp/github-repo
                fi
                mkdir -p .github
                ln -s /tmp/github-repo/rust-cli-kiln .github/rust-cli-kiln
            fi
        fi
    fi
    
    # Verify setup
    echo "Environment setup complete:"
    echo "  Current directory: $(pwd)"
    echo "  Project: $project_name"
    echo "  rust-cli-kiln available: $([ -d ".github/rust-cli-kiln" ] && echo "Yes" || echo "No")"
    
    # Export for use by scripts
    export PROJECT_NAME="$project_name"
    export PROJECT_ROOT="$(pwd)"
    
    return 0
}

# Check if running in GitHub Actions
is_github_actions() {
    [ -n "${GITHUB_ACTIONS:-}" ]
}

# Get execution environment description
get_execution_mode() {
    if is_github_actions; then
        echo "GitHub Actions"
    else
        echo "Local"
    fi
}

# Print standardized script header
print_script_header() {
    local script_name="$1"
    local description="$2"
    
    echo "=== $script_name - AI Optimized ==="
    echo "$description"
    echo "Project: $PROJECT_NAME"
    echo "Project root: $PROJECT_ROOT"
    echo "Execution mode: $(get_execution_mode)"
    echo ""
}