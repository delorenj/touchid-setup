package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	"github.com/charmbracelet/huh"
	"github.com/charmbracelet/lipgloss"
)

var (
	style = lipgloss.NewStyle().
		Foreground(lipgloss.Color("#FF06B7")).
		Bold(true)

	successStyle = lipgloss.NewStyle().
		Foreground(lipgloss.Color("#04B575")).
		Bold(true)
)

func main() {
	// Welcome message
	fmt.Println(style.Render("🔐 TouchyMcRootFace Setup"))
	fmt.Println()

	// Check if running on macOS
	out, err := exec.Command("uname").Output()
	if err != nil || strings.TrimSpace(string(out)) != "Darwin" {
		fmt.Println("❌ This script only works on macOS")
		os.Exit(1)
	}

	// Confirm setup
	var confirmed bool
	form := huh.NewForm(
		huh.NewGroup(
			huh.NewConfirm().
				Title("Would you like to enable Touch ID for sudo?").
				Value(&confirmed),
		),
	)

	err = form.Run()
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}

	if !confirmed {
		fmt.Println("Setup cancelled")
		os.Exit(0)
	}

	// Backup existing configuration
	backupPath := "/etc/pam.d/sudo.bak"
	if _, err := os.Stat(backupPath); os.IsNotExist(err) {
		exec.Command("sudo", "cp", "/etc/pam.d/sudo", backupPath).Run()
		fmt.Println(successStyle.Render("✓ Backup created at " + backupPath))
	}

	// Create new PAM configuration
	pamConfig := []byte(`# sudo: auth account password session
auth       sufficient     pam_tid.so
auth       include        sudo_local
auth       sufficient     pam_smartcard.so
auth       required       pam_opendirectory.so
account    required       pam_permit.so
password   required       pam_deny.so
session    required       pam_permit.so
`)

	tmpFile := filepath.Join(os.TempDir(), "sudo_pam_config")
	if err := os.WriteFile(tmpFile, pamConfig, 0644); err != nil {
		fmt.Println("Error creating config:", err)
		os.Exit(1)
	}

	// Move configuration file
	if err := exec.Command("sudo", "mv", tmpFile, "/etc/pam.d/sudo").Run(); err != nil {
		fmt.Println("Error installing config:", err)
		os.Exit(1)
	}

	fmt.Println(successStyle.Render("✓ Touch ID configuration installed"))

	// Test configuration
	fmt.Println("\n🔍 Testing Touch ID authentication...")
	fmt.Println("You should see a Touch ID prompt. Please authenticate:")

	cmd := exec.Command("sudo", "-K")
	cmd.Run()
	cmd = exec.Command("sudo", "echo", "TouchyMcRootFace is working!")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Run()

	fmt.Println(style.Render("\n✨ Setup complete! You can now use TouchyMcRootFace for sudo commands"))
	fmt.Println("\nTo revert changes:")
	fmt.Printf("sudo mv %s /etc/pam.d/sudo\n", backupPath)
}
