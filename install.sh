#!/bin/bash
set -e

echo "🔐 Installing TouchID Sudo Setup..."

# Determine installation directory
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

# Download latest release
LATEST_URL="https://github.com/jarad/touchid-setup/releases/latest/download/touchid-setup-darwin-arm64"
if [ "$(uname -m)" = "x86_64" ]; then
    LATEST_URL="https://github.com/jarad/touchid-setup/releases/latest/download/touchid-setup-darwin-amd64"
fi

echo "📥 Downloading latest version..."
curl -L -o "$INSTALL_DIR/touchid-setup" "$LATEST_URL"
chmod +x "$INSTALL_DIR/touchid-setup"

# Add to PATH if needed
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "Adding $INSTALL_DIR to PATH..."
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    export PATH="$INSTALL_DIR:$PATH"
fi

echo "✨ Installation complete! Run 'touchid-setup' to configure Touch ID for sudo"
