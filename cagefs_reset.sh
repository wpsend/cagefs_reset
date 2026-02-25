#!/bin/bash

# ==============================
# CageFS Reset Script
# Usage: ./cagefs_reset.sh username
# ==============================

USER_NAME="$1"

# Check if username provided
if [ -z "$USER_NAME" ]; then
    echo "Usage: $0 username"
    exit 1
fi

HOME_DIR="/home/$USER_NAME"
CAGEFS_DIR="$HOME_DIR/.cagefs"

# Check if user exists
if ! id "$USER_NAME" &>/dev/null; then
    echo "User $USER_NAME does not exist!"
    exit 1
fi

echo "--------------------------------------"
echo "Checking current .cagefs size..."
du -sh "$CAGEFS_DIR" 2>/dev/null
echo "--------------------------------------"

echo "Disabling CageFS for $USER_NAME..."
cagefsctl --disable "$USER_NAME"

if [ -d "$CAGEFS_DIR" ]; then
    echo "Removing old .cagefs directory..."
    rm -rf "$CAGEFS_DIR"
else
    echo ".cagefs directory not found."
fi

echo "Re-enabling CageFS for $USER_NAME..."
cagefsctl --enable "$USER_NAME"

echo "Force updating CageFS..."
cagefsctl --force-update

echo "Fixing quotas..."
/scripts/fixquotas

echo "--------------------------------------"
echo "New .cagefs size:"
du -sh "$CAGEFS_DIR" 2>/dev/null
echo "--------------------------------------"

echo "CageFS reset completed for $USER_NAME"
