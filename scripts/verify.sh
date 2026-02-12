#!/usr/bin/env bash
# Lab Verification Script
# Run this to validate lab configuration and compliance

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_ROOT="$(dirname "$SCRIPT_DIR")"

echo "=== Lab Verification ==="
echo "Lab root: $LAB_ROOT"
echo ""

ERRORS=0

check_file() {
    local file="$1"
    local description="$2"
    if [[ -f "$LAB_ROOT/$file" ]]; then
        echo "  ✓ $description ($file)"
        return 0
    else
        echo "  ✗ $description ($file) MISSING"
        ((ERRORS++))
        return 1
    fi
}

check_dir() {
    local dir="$1"
    local description="$2"
    if [[ -d "$LAB_ROOT/$dir" ]]; then
        echo "  ✓ $description ($dir/)"
        return 0
    else
        echo "  ✗ $description ($dir/) MISSING"
        ((ERRORS++))
        return 1
    fi
}

# Core files
echo "Checking core files..."
check_file "README.md" "README"
check_file ".labtemplate" "Template manifest"
check_file ".pre-commit-config.yaml" "Pre-commit config"
check_file "AGENTS.md" "Agent context"
check_file ".gitignore" "Git ignore"

echo ""

# Optional but recommended
echo "Checking recommended files..."
check_file ".env.example" "Environment example" || true
check_file "CONTRIBUTING.md" "Contributing guide" || true
check_dir "scripts" "Scripts directory" || true

echo ""

# Pre-commit hooks
echo "Checking pre-commit hooks..."
if [[ -f "$LAB_ROOT/.git/hooks/pre-commit" ]]; then
    echo "  ✓ Pre-commit hooks installed"
else
    echo "  ⚠ Pre-commit hooks not installed (run: pre-commit install)"
fi

echo ""

# Summary
if [[ $ERRORS -eq 0 ]]; then
    echo "=== Verification PASSED ==="
    exit 0
else
    echo "=== Verification FAILED ($ERRORS errors) ==="
    exit 1
fi
