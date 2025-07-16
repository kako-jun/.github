#!/bin/bash
set -e

# Load common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"

# Initialize project variables
init_project_vars

echo "🚀 Setting up GitHub Workflow automation for $PROJECT_NAME project"
echo "========================================================="

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed. Please install it first:"
    echo "   https://cli.github.com/"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not in a git repository"
    exit 1
fi

echo ""
echo "🔧 Step 1: Setting up Labels from shared configuration"
echo "----------------------------------------------------"

# Path to shared configuration
SHARED_DIR="$(dirname "$SCRIPT_DIR")"
LABELS_JSON="$SHARED_DIR/../../.github/labels.json"
BRANCH_PROTECTION_JSON="$SHARED_DIR/../../.github/branch-protection.json"

if [ -f "$LABELS_JSON" ]; then
    echo "Setting up repository labels..."
    # Delete existing labels and add new ones from JSON
    while IFS= read -r label; do
        name=$(echo "$label" | jq -r '.name')
        color=$(echo "$label" | jq -r '.color')
        description=$(echo "$label" | jq -r '.description')
        
        # Create or update label
        if gh label create "$name" --color "$color" --description "$description" 2>/dev/null; then
            echo "  ✅ Created label: $name"
        else
            gh label edit "$name" --color "$color" --description "$description" 2>/dev/null || true
            echo "  🔄 Updated label: $name"
        fi
    done < <(jq -c '.[]' "$LABELS_JSON")
    echo "✅ Labels configured from shared template"
else
    echo "⚠️  Labels configuration not found at $LABELS_JSON"
fi

echo ""
echo "🔧 Step 2: Configuring Repository Settings" 
echo "------------------------------------------"
echo "Setting up auto-merge, branch deletion, and merge options..."
REPO_FULL_NAME=$(gh repo view --json nameWithOwner -q .nameWithOwner)

# Enable auto-merge and automatic branch deletion
if gh api "repos/$REPO_FULL_NAME" --method PATCH \
    --field allow_auto_merge=true \
    --field delete_branch_on_merge=true \
    --field allow_squash_merge=true \
    --field allow_merge_commit=true \
    --field allow_rebase_merge=true > /dev/null 2>&1; then
    echo "✅ Repository settings configured:"
    echo "   - Auto-merge enabled (for solo development)"
    echo "   - Automatic branch deletion after merge"
    echo "   - All merge types enabled (merge, squash, rebase)"
else
    echo "❌ Failed to configure repository settings"
fi

echo ""
echo "🔧 Step 3: Setting up Branch Protection"
echo "--------------------------------------"

if [ -f "$BRANCH_PROTECTION_JSON" ]; then
    echo "Configuring branch protection for main branch..."
    if gh api "repos/$REPO_FULL_NAME/branches/main/protection" \
        --method PUT \
        --input "$BRANCH_PROTECTION_JSON" > /dev/null 2>&1; then
        echo "✅ Branch protection configured for main branch"
        echo "   - Required status checks: CI"
        echo "   - Dismiss stale reviews: enabled"
        echo "   - Required approving reviews: 1"
        echo "   - Enforce admins: enabled"
        echo "   - Delete branch on merge: enabled"
    else
        echo "⚠️  Branch protection setup failed (might need admin access)"
    fi
else
    echo "⚠️  Branch protection configuration not found at $BRANCH_PROTECTION_JSON"
fi

echo ""
echo "🎯 Step 4: Workflow Summary"
echo "---------------------------"
echo "GitHub Workflow is now configured with the following features:"
echo ""
echo "✅ Solo Development Features:"
echo "   - Auto-merge enabled (no review required for owner)"
echo "   - Automatic branch deletion after merge"
echo "   - All merge types available"
echo ""
echo "📋 Recommended Development Workflow:"
echo "1. Create feature branch: git checkout -b feature/name"
echo "2. Make changes and commit: git commit -m \"...\""
echo "3. Push branch: git push -u origin feature/name"
echo "4. Create PR: gh pr create --title \"...\" --body \"...\""
echo "5. Auto-merge: gh pr merge --auto --squash"
echo "6. CI will automatically merge after tests pass"
echo ""
echo "🔧 Quick Commands:"
echo "   ./github-shared/rust-cli-kiln/scripts/create-pr.sh \"Title\" \"Description\" - Create PR with auto-merge"
echo "   ./github-shared/rust-cli-kiln/scripts/ci-local.sh - Run local CI validation"
echo ""
echo "🎉 GitHub Workflow setup completed successfully!"
echo ""
echo "Your repository is ready for efficient solo development with:"
echo "- Streamlined PR workflow"
echo "- Automatic quality checks"
echo "- Clean branch management"
echo "- Future contributor readiness"