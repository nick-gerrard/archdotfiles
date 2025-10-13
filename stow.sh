#!/usr/bin/env bash

# A script to clean, create, and stow a dotfile package from
# the common and host-specific directories.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- CONFIGURATION ---
# Your dotfiles directory.
DOTFILES_DIR=$(dirname "$(readlink -f "0")")

# The target directory for the symlinks.
STOW_TARGET_DIR="$HOME"
# --- END CONFIGURATION ---

# 1. Argument Check
# Check if a package name was provided.
if [ -z "$1" ]; then
  echo "Usage: $0 <package-name>"
  echo "Example: $0 hypr"
  exit 1
fi

PACKAGE_NAME="$1"
HOSTNAME=$(uname -n)
PACKAGE_CONFIG_PATH="$STOW_TARGET_DIR/.config/$PACKAGE_NAME"

echo "🚀 Stowing package: $PACKAGE_NAME for host: $HOSTNAME"

# 2. Cleanup Phase
echo "🧹 Cleaning up old configuration..."
# Unstow from both locations. The -D flag is safe even if nothing is stowed.
stow -D --dir="$DOTFILES_DIR/hosts/$HOSTNAME" --target="$STOW_TARGET_DIR" "$PACKAGE_NAME" 2>/dev/null || true
stow -D --dir="$DOTFILES_DIR/common" --target="$STOW_TARGET_DIR" "$PACKAGE_NAME" 2>/dev/null || true

# Remove the old target directory if it exists.
if [ -e "$PACKAGE_CONFIG_PATH" ]; then
  echo "   - Removing existing target directory: $PACKAGE_CONFIG_PATH"
  rm -rf "$PACKAGE_CONFIG_PATH"
fi

# 3. Create Target Directory
echo "📁 Creating new target directory..."
mkdir -p "$PACKAGE_CONFIG_PATH"

# 4. Stow Phase
HOST_CONFIG_DIR="$DOTFILES_DIR/hosts/$HOSTNAME/$PACKAGE_NAME"
COMMON_CONFIG_DIR="$DOTFILES_DIR/common/$PACKAGE_NAME"

# Stow the host-specific config ONLY if it exists.
if [ -d "$HOST_CONFIG_DIR" ]; then
  echo "   - Stowing host-specific config..."
  stow --dir="$DOTFILES_DIR/hosts/$HOSTNAME" --target="$STOW_TARGET_DIR" "$PACKAGE_NAME"
else
  echo "   - No host-specific config found. Skipping."
fi

# Stow the common config.
if [ -d "$COMMON_CONFIG_DIR" ]; then
  echo "   - Stowing common config..."
  stow --dir="$DOTFILES_DIR/common" --target="$STOW_TARGET_DIR" "$PACKAGE_NAME"
else
  echo "   - WARNING: No common config found for $PACKAGE_NAME."
fi

echo "✅ Done."
