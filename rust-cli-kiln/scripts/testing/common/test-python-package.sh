#!/bin/bash

# Test Python package functionality
# Usage: test-python-package.sh <source_type> [package_path]
#   source_type: "local" or "published"
#   package_path: path to Python package (required for local, ignored for published)

set -eo pipefail

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../../utils/common.sh"
source "$SCRIPT_DIR/test-utils.sh"

# Initialize project variables
init_project_vars

# Parse arguments
SOURCE_TYPE="${1:-published}"
PACKAGE_PATH="${2:-}"

# Main test function
test_python_package() {
    info "Testing Python package functionality (${SOURCE_TYPE})"
    
    # Check if Python and uv are available
    if ! check_command "python3"; then
        error "Python 3 is required for Python package testing"
        return 1
    fi
    
    # Install uv if not available
    if ! check_command "uv"; then
        info "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh >/dev/null 2>&1
        source ~/.cargo/env
    fi
    
    # Create test environment
    local test_dir=$(create_test_dir "python-test")
    cd "$test_dir"
    
    # Create virtual environment
    uv venv python-test-env >/dev/null 2>&1
    source python-test-env/bin/activate
    
    # Install package
    if is_published_test "$SOURCE_TYPE"; then
        info "Installing ${PROJECT_NAME}-python from PyPI..."
        if ! uv pip install "${PROJECT_NAME}-python" >/dev/null 2>&1; then
            error "Failed to install ${PROJECT_NAME}-python from PyPI"
            return 1
        fi
        PACKAGE_NAME="${PROJECT_NAME}-python"
    else
        # For local test, check if wheel already installed in current environment
        if python3 -c "import ${PROJECT_NAME//-/_}_python" >/dev/null 2>&1; then
            info "${PROJECT_NAME}-python already installed in current environment"
            PACKAGE_NAME="${PROJECT_NAME}-python"
        else
            # Install from local path
            if [ -z "$PACKAGE_PATH" ] || [ ! -d "$PACKAGE_PATH" ]; then
                error "Package path not found: $PACKAGE_PATH"
                return 1
            fi
            info "Installing ${PROJECT_NAME}-python from local path..."
            if ! uv pip install -e "$PACKAGE_PATH" >/dev/null 2>&1; then
                error "Failed to install from local path: $PACKAGE_PATH"
                return 1
            fi
            PACKAGE_NAME="${PROJECT_NAME}-python"
        fi
    fi
    
    # Test 1: CLI functionality
    run_test "CLI version command" "${PROJECT_NAME} --version"
    run_test "CLI help command" "${PROJECT_NAME} --help"
    
    # Test 2: Create test files and run CLI
    echo '{"name": "test", "value": 1}' > file1.json
    echo '{"name": "test", "value": 2}' > file2.json
    
    run_test "CLI diff functionality" "${PROJECT_NAME} file1.json file2.json"
    run_test "CLI JSON output" "${PROJECT_NAME} file1.json file2.json --output json"
    
    # Test 3: Python module import and basic usage
    cat > test_import.py << EOF
#!/usr/bin/env python3

import sys
import subprocess

def test_import():
    """Test importing the Python module"""
    try:
        # Import the Python module (diffai-python package -> diffai_python module)
        module_name = '${PROJECT_NAME//-/_}_python'
        try:
            exec(f'import {module_name}')
            print(f"✓ Successfully imported {module_name}")
        except ImportError as e:
            print(f"✗ Failed to import {module_name}: {e}")
            return False
            
        return True
    except Exception as e:
        print(f"✗ Import test failed: {e}")
        return False

def test_cli_via_subprocess():
    """Test CLI via subprocess"""
    try:
        result = subprocess.run(
            ['${PROJECT_NAME}', '--version'], 
            capture_output=True, 
            text=True, 
            check=True
        )
        print(f"✓ CLI via subprocess: {result.stdout.strip()}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"✗ CLI subprocess test failed: {e}")
        return False
    except Exception as e:
        print(f"✗ CLI subprocess test error: {e}")
        return False

def test_basic_functionality():
    """Test basic Python API functionality"""
    try:
        # Test CLI via subprocess
        result = subprocess.run(
            ['${PROJECT_NAME}', 'file1.json', 'file2.json'],
            capture_output=True,
            text=True,
            check=True
        )
        print("✓ CLI diff functionality works")
        
        # Test Python API function call
        module_name = '${PROJECT_NAME//-/_}_python'
        exec(f'''
import {module_name}
result = {module_name}.diff("file1.json", "file2.json")
print(f"✓ Python API diff function works: {{type(result)}}")
''')
        return True
    except subprocess.CalledProcessError as e:
        print(f"✗ CLI functionality test failed: {e}")
        return False
    except Exception as e:
        print(f"✗ Python API test failed: {e}")
        return False

def main():
    print("Running Python package tests...")
    
    tests = [
        ("Module import", test_import),
        ("CLI via subprocess", test_cli_via_subprocess), 
        ("Basic functionality", test_basic_functionality)
    ]
    
    passed = 0
    for test_name, test_func in tests:
        print(f"\nTesting {test_name}...")
        if test_func():
            passed += 1
        else:
            print(f"Test {test_name} failed")
    
    print(f"\nResults: {passed}/{len(tests)} tests passed")
    
    if passed == len(tests):
        print("All Python API tests passed!")
        return 0
    else:
        return 1

if __name__ == "__main__":
    sys.exit(main())
EOF
    
    run_test "Python module and API functionality" "python3 test_import.py"
    
    # Test 4: Run package tests using standard pytest
    if is_published_test "$SOURCE_TYPE"; then
        # For published packages, try to run pytest
        if uv pip install pytest >/dev/null 2>&1 && python3 -m pytest >/dev/null 2>&1; then
            run_test "Package test suite" "python3 -m pytest"
        else
            warning "No pytest configuration found in published package"
        fi
    else
        # For local packages, run pytest in the package directory
        if (cd "$PACKAGE_PATH" && python3 -m pytest >/dev/null 2>&1); then
            run_test "Local package test suite" "(cd '$PACKAGE_PATH' && python3 -m pytest)"
        else
            warning "No pytest configuration found in local package"
        fi
    fi
    
    # Test 5: Error handling
    if python3 -c "import subprocess; subprocess.run(['${PROJECT_NAME}', 'nonexistent.json', 'file1.json'], check=True, capture_output=True)" >/dev/null 2>&1; then
        error "Should fail with non-existent file"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    else
        success "Properly handles non-existent file"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    fi
    TESTS_RUN=$((TESTS_RUN + 1))
    
    # Deactivate virtual environment
    deactivate
    
    cd "$PROJECT_ROOT"
    
    print_test_summary
}

# Run tests
test_python_package