#!/bin/bash
set -e

echo "🔨 Installing dependencies..."
go mod init touchymcrootface
go get github.com/charmbracelet/bubbles/spinner
go get github.com/charmbracelet/bubbletea
go get github.com/charmbracelet/huh
go get github.com/charmbracelet/lipgloss

echo "📦 Building touchymcrootface..."
go build -o touchymcrootface touchymcrootface.go

echo "✨ Done! Run ./touchymcrootface to configure touchymcrootface"
