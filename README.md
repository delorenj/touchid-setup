# touchymcrootface

A pretty neat CLI tool to enable Touch ID authentication for sudo commands on macOS.

![Demo Screenshot](./demo.png)

## Features

- 🔐 Enable Touch ID for sudo authentication
- 🪄 CLI interface using [Charm](https://charm.sh) libraries
- 🔄 Automatic backup of original configuration
- ✨ Easy to revert changes

## Installation

### Using Homebrew

```bash
brew install delorenj/tap/touchymcrootface
```

### Manual Installation

Download the latest release from the [releases page](https://github.com/delorenj/touchymcrootface/releases).

Or install directly using:

```bash
curl -sSL https://raw.githubusercontent.com/delorenj/touchymcrootface/main/install.sh | bash
```

## Usage

Simply run:

```bash
touchymcrootface
```

Follow the interactive prompts to enable Touch ID for sudo.

## How it Works

This tool modifies the PAM (Pluggable Authentication Modules) configuration for sudo to enable Touch ID authentication. It:

1. Creates a backup of your current sudo configuration
2. Adds Touch ID as an authentication method
3. Tests the configuration
4. Provides instructions for reverting changes if needed

## Reverting Changes

If you need to revert to the original configuration:

```bash
sudo mv /etc/pam.d/sudo.bak /etc/pam.d/sudo
```

## Requirements

- macOS 10.15 (Catalina) or later
- Touch ID capable Mac
- Touch ID enabled and configured

## Development

To build from source:

```bash
git clone https://github.com/delorenj/touchid-setup.git
cd touchid-setup
./build.sh
```

## License

MIT License - see [LICENSE](LICENSE)
