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