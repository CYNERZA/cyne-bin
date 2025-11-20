#!/bin/bash
# Cyne CLI Linux Installer
# This script downloads and installs Cyne CLI for Linux

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo ""
echo -e "${CYAN}================================${NC}"
echo -e "${CYAN}  Cyne CLI Linux Installer${NC}"
echo -e "${CYAN}================================${NC}"
echo ""

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        BINARY_NAME="cyne-linux-x86_64"
        ;;
    aarch64|arm64)
        BINARY_NAME="cyne-linux-aarch64"
        ;;
    armv7l|armv7)
        BINARY_NAME="cyne-linux-armv7"
        ;;
    *)
        echo -e "${RED}Error: Unsupported architecture: $ARCH${NC}"
        echo "Supported: x86_64, aarch64, armv7"
        exit 1
        ;;
esac

echo -e "${GREEN}Detected architecture: $ARCH${NC}"
echo -e "Binary to download: $BINARY_NAME"
echo ""

# Determine installation directory
if [ "$EUID" -eq 0 ]; then
    INSTALL_DIR="/usr/local/bin"
    echo -e "${GREEN}Running as root. Installing system-wide.${NC}"
else
    INSTALL_DIR="$HOME/.local/bin"
    echo -e "${YELLOW}Running as user. Installing to: $INSTALL_DIR${NC}"
    mkdir -p "$INSTALL_DIR"
fi

echo -e "Installation directory: $INSTALL_DIR"
echo ""

# Download binary
echo -e "${CYAN}Downloading Cyne CLI...${NC}"
DOWNLOAD_URL="https://github.com/CYNERZA/cyne-bin/releases/latest/download/$BINARY_NAME"
TEMP_FILE="/tmp/cyne-installer-$$"

if command -v curl &> /dev/null; then
    curl -L -o "$TEMP_FILE" "$DOWNLOAD_URL"
elif command -v wget &> /dev/null; then
    wget -O "$TEMP_FILE" "$DOWNLOAD_URL"
else
    echo -e "${RED}Error: Neither curl nor wget found. Please install one of them.${NC}"
    exit 1
fi

echo -e "${GREEN}Download complete!${NC}"
echo ""

# Install binary
echo -e "${CYAN}Installing binary...${NC}"
chmod +x "$TEMP_FILE"
mv "$TEMP_FILE" "$INSTALL_DIR/cyne"
echo -e "${GREEN}Installed to: $INSTALL_DIR/cyne${NC}"
echo ""

# Check PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${YELLOW}Warning: $INSTALL_DIR is not in your PATH${NC}"
    echo ""
    echo "Add to PATH by adding this line to your ~/.bashrc or ~/.zshrc:"
    echo -e "${CYAN}export PATH=\"\$PATH:$INSTALL_DIR\"${NC}"
    echo ""
fi

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo -e "Usage:"
echo -e "  ${CYAN}cyne${NC}                    - Start interactive mode"
echo -e "  ${CYAN}cyne \"your prompt\"${NC}      - Run single command"
echo -e "  ${CYAN}cyne --help${NC}             - Show help"
echo ""
echo -e "Configuration:"
echo -e "  Config file: ${CYAN}~/.cyne/config.json${NC}"
echo -e "  Run 'cyne' and use /config commands to set API keys"
echo ""
echo -e "Examples:"
echo -e '  cyne'
echo -e '  cyne "Create a Python script"'
echo -e '  cyne --think "Solve complex problem"'
echo ""
