#!/bin/bash
set -e

echo "🔨 Installing dependencies..."
go mod init touchid-setup
go get github.com/charmbracelet/bubbles/spinner
go get github.com/charmbracelet/bubbletea
go get github.com/charmbracelet/huh
go get github.com/charmbracelet/lipgloss

echo "📦 Building setup-touchid..."
go build -o setup-touchid setup-touchid.go

echo "✨ Done! Run ./setup-touchid to configure Touch ID for sudo"
