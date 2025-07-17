#!/bin/bash

# Common test utilities for rust-cli-kiln testing framework
# Used by all test scripts for consistent logging and error handling

# Colors for output
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export NC='\033[0m'

# Logging functions
log() {
    echo -e "${BLUE}[$(date +'%H:%M:%S')] $1${NC}"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Test result tracking
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Test execution wrapper
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    info "Running: $test_name"
    
    if eval "$test_command" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        success "$test_name"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        error "$test_name"
        return 1
    fi
}

# Print test summary
print_test_summary() {
    echo ""
    echo "Test Summary:"
    echo "============="
    echo "Total tests: $TESTS_RUN"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    if [ $TESTS_FAILED -gt 0 ]; then
        echo -e "${RED}Failed: $TESTS_FAILED${NC}"
    fi
    echo ""
    
    if [ $TESTS_FAILED -eq 0 ]; then
        success "All tests passed!"
        return 0
    else
        error "Some tests failed!"
        return 1
    fi
}

# Create temporary test directory
create_test_dir() {
    local prefix="${1:-test}"
    TEMP_DIR=$(mktemp -d -t "${prefix}-XXXXXX")
    trap "rm -rf $TEMP_DIR" EXIT
    echo "$TEMP_DIR"
}

# Check if command exists
check_command() {
    local cmd="$1"
    if ! command -v "$cmd" &> /dev/null; then
        error "$cmd is not installed"
        return 1
    fi
    return 0
}

# Get package source path or name
get_package_source() {
    local source_type="$1"  # "local" or "published"
    local local_path="$2"   # path for local source
    local package_name="$3" # package name for published source
    
    if [ "$source_type" = "local" ]; then
        echo "$local_path"
    else
        echo "$package_name"
    fi
}

# Determine if we're testing local or published packages
is_published_test() {
    [ "$1" = "published" ]
}