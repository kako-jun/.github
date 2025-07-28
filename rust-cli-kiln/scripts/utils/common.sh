#!/bin/bash

# Common utility functions for rust-cli-kiln scripts (Simplified version)

# Get project name from current directory (unified for local and GitHub Actions)
get_project_name() {
    basename "$(pwd)"
}

# Get execution mode (local vs github-actions)
get_execution_mode() {
    if [ -n "${GITHUB_ACTIONS:-}" ]; then
        echo "github-actions"
    else
        echo "local"
    fi
}

# Simple unified environment setup for both local and GitHub Actions
# Assumes current directory is project root (diffx, lawkit, diffai)
setup_unified_env() {
    # Simple: project name is current directory name
    PROJECT_NAME=$(get_project_name)
    PROJECT_ROOT="$(pwd)"
    
    echo "Setting up unified environment:"
    echo "  Project: $PROJECT_NAME"
    echo "  Project root: $PROJECT_ROOT"
    echo "  Execution mode: $(get_execution_mode)"
    
    # Verify we're in a valid project directory
    if [ ! -f "Cargo.toml" ]; then
        echo "Error: No Cargo.toml found in current directory"
        echo "Please run from project root (diffx, lawkit, or diffai)"
        return 1
    fi
    
    # Verify github-shared symlink exists
    if [ ! -d "github-shared" ]; then
        echo "Error: github-shared symlink not found"
        echo "Please run scripts/utils/create-github-shared-symlink.sh first"
        return 1
    fi
    
    # Export for use by scripts
    export PROJECT_NAME PROJECT_ROOT
    
    echo "✅ Environment setup complete"
    return 0
}

# Legacy alias for backward compatibility
setup_github_actions_env() {
    setup_unified_env "$@"
}

# Initialize project variables (legacy compatibility)
init_project_vars() {
    setup_unified_env
}

# Check if running in GitHub Actions
is_github_actions() {
    [ -n "${GITHUB_ACTIONS:-}" ]
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