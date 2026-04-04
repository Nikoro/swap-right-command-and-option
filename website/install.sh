#!/bin/bash
set -euo pipefail

PLIST_NAME="com.local.swap-right-command-and-option.plist"
LAUNCH_AGENTS="$HOME/Library/LaunchAgents"
DEST="$LAUNCH_AGENTS/$PLIST_NAME"
RAW_URL="https://raw.githubusercontent.com/Nikoro/swap-right-command-and-option/main/$PLIST_NAME"

echo "==> Downloading $PLIST_NAME..."
mkdir -p "$LAUNCH_AGENTS"
curl -fsSL "$RAW_URL" -o "$DEST"

echo "==> Unloading old agent (if any)..."
launchctl bootout "gui/$(id -u)" "$DEST" 2>/dev/null || true

echo "==> Loading agent..."
launchctl bootstrap "gui/$(id -u)" "$DEST"

echo "==> Done! Right Command and Right Option are now swapped."
echo "    This will persist across reboots."
