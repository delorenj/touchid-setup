#!/bin/bash
set -e

echo "🔐 Installing Touchymcrootface..."

# Determine installation directory
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

# Download latest release
LATEST_URL="https://github.com/delorenj/touchymcrootface/releases/latest/download/touchymcrootface-darwin-arm64"
if [ "$(uname -m)" = "x86_64" ]; then
    LATEST_URL="https://github.com/delorenj/touchymcrootface/releases/latest/download/touchymcrootface-darwin-amd64"
fi

echo "📥 Downloading latest version..."
curl -L -o "$INSTALL_DIR/touchymcrootface" "$LATEST_URL"
chmod +x "$INSTALL_DIR/touchymcrootface"

# Add to PATH if needed
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "Adding $INSTALL_DIR to PATH..."
    echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.zshrc
    export PATH="$INSTALL_DIR:$PATH"
fi

echo "✨ Installation complete! Run 'touchymcrootface' to configure Touchymcrootface"
