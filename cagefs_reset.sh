#!/bin/bash

# ==========================================================
# CageFS Reset Script for CloudLinux + cPanel Servers
# Author: wpsend
# Repository: https://github.com/wpsend/cagefs_reset
# Description: Best Web Hosting In Bangladesh Hostserverbd.com
# Safely resets and rebuilds CageFS environment for a user
# to fix abnormal .cagefs disk usage issues.
# ==========================================================

USER_NAME="$1"

# -----------------------------
# Function: Show usage
# -----------------------------
usage() {
    echo "Usage: $0 username"
    echo "Example: $0 myhostserverbd"
    exit 1
}

# -----------------------------
# Check root user
# -----------------------------
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

# -----------------------------
# Validate input
# -----------------------------
if [ -z "$USER_NAME" ]; then
    usage
fi

# -----------------------------
# Check if user exists
# -----------------------------
if ! id "$USER_NAME" &>/dev/null; then
    echo "Error: User '$USER_NAME' does not exist."
    exit 1
fi

HOME_DIR="/home/$USER_NAME"
CAGEFS_DIR="$HOME_DIR/.cagefs"

echo "--------------------------------------------"
echo "CageFS Reset Tool"
echo "User: $USER_NAME"
echo "--------------------------------------------"

echo "[1/6] Checking current .cagefs size..."
du -sh "$CAGEFS_DIR" 2>/dev/null || echo ".cagefs not found."

echo "[2/6] Disabling CageFS..."
cagefsctl --disable "$USER_NAME"

echo "[3/6] Removing old .cagefs directory..."
if [ -d "$CAGEFS_DIR" ]; then
    rm -rf "$CAGEFS_DIR"
    echo ".cagefs removed."
else
    echo "No existing .cagefs directory."
fi

echo "[4/6] Re-enabling CageFS..."
cagefsctl --enable "$USER_NAME"

echo "[5/6] Updating CageFS skeleton..."
cagefsctl --force-update

echo "[6/6] Fixing quotas..."
/scripts/fixquotas

echo "--------------------------------------------"
echo "New .cagefs size:"
du -sh "$CAGEFS_DIR" 2>/dev/null
echo "--------------------------------------------"
echo "CageFS reset completed successfully for $USER_NAME"
echo "--------------------------------------------"
