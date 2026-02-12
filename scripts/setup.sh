#!/usr/bin/env bash
# Lab Setup Script
# Run this after cloning to set up the development environment

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_ROOT="$(dirname "$SCRIPT_DIR")"

echo "=== Lab Setup ==="
echo "Lab root: $LAB_ROOT"

# Check dependencies
echo ""
echo "Checking dependencies..."

check_command() {
    if command -v "$1" &> /dev/null; then
        echo "  ✓ $1 found"
        return 0
    else
        echo "  ✗ $1 not found"
        return 1
    fi
}

check_command git
check_command python3 || check_command python

# Install pre-commit if available
if command -v pip3 &> /dev/null || command -v pip &> /dev/null; then
    echo ""
    echo "Installing pre-commit hooks..."
    pip3 install pre-commit 2>/dev/null || pip install pre-commit 2>/dev/null || true
    if command -v pre-commit &> /dev/null; then
        cd "$LAB_ROOT"
        pre-commit install
        echo "  ✓ Pre-commit hooks installed"
    fi
fi

# Create .env from example if it doesn't exist
if [[ -f "$LAB_ROOT/.env.example" ]] && [[ ! -f "$LAB_ROOT/.env" ]]; then
    echo ""
    echo "Creating .env from .env.example..."
    cp "$LAB_ROOT/.env.example" "$LAB_ROOT/.env"
    echo "  ✓ .env created (edit with your values)"
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit .env with your configuration"
echo "  2. Review README.md for lab-specific setup"
echo "  3. Run ./scripts/verify.sh to validate"
