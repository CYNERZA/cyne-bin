# Cyne CLI - Binary Downloads

[![GitHub release](https://img.shields.io/github/v/release/CYNERZA/cyne-bin)](https://github.com/CYNERZA/cyne-bin/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Precompiled binaries for [Cyne CLI](https://github.com/CYNERZA/cyne-cli) - A terminal-based AI assistant using ReAct architecture with multiple LLM provider support.

## Quick Install

### Linux (x86_64)
```bash
# Download the binary
wget https://github.com/CYNERZA/cyne-bin/releases/latest/download/cyne-linux-x86_64

# Make it executable
chmod +x cyne-linux-x86_64

# Move to PATH (optional)
sudo mv cyne-linux-x86_64 /usr/local/bin/cyne

# Run
cyne
```

### Linux (ARM64/aarch64) - For Raspberry Pi, ARM servers, etc.
```bash
# Download the binary
wget https://github.com/CYNERZA/cyne-bin/releases/latest/download/cyne-linux-aarch64

# Make it executable
chmod +x cyne-linux-aarch64

# Move to PATH (optional)
sudo mv cyne-linux-aarch64 /usr/local/bin/cyne

# Run
cyne
```

### Windows (x86_64)
```powershell
# Download from releases page or use PowerShell
Invoke-WebRequest -Uri "https://github.com/CYNERZA/cyne-bin/releases/latest/download/cyne-windows-x86_64.exe" -OutFile "cyne.exe"

# Run
.\cyne.exe
```

Or simply download `cyne-windows-x86_64.exe` from the [releases page](https://github.com/CYNERZA/cyne-bin/releases/latest) and double-click to run.

### Termux (Android)
```bash
# Install on ARM64 Android devices
pkg install wget
wget https://github.com/CYNERZA/cyne-bin/releases/latest/download/cyne-linux-aarch64
chmod +x cyne-linux-aarch64
mv cyne-linux-aarch64 $PREFIX/bin/cyne
cyne
```

## Verifying Installation

After installation, verify by running:
```bash
cyne --version
```

## Configuration

On first run, Cyne will create a configuration directory:
- **Linux/macOS/Termux**: `~/.cyne/`
- **Windows**: `C:\Users\YourName\.cyne\`

Configuration file: `~/.cyne/config.json`

### Setting up API Keys

Cyne supports multiple LLM providers. Configure your preferred provider:

```bash
# Interactive configuration
cyne

# Then use commands like:
# /config openai YOUR_API_KEY
# /config anthropic YOUR_API_KEY
# /config google YOUR_API_KEY
```

Or manually edit `~/.cyne/config.json`:
```json
{
  "openai_api_key": "sk-...",
  "anthropic_api_key": "sk-ant-...",
  "google_api_key": "AI..."
}
```

## Supported Platforms

| Platform | Architecture | Binary Name | Status |
|----------|-------------|-------------|--------|
| Linux | x86_64 | `cyne-linux-x86_64` | ✅ Available |
| Linux | ARM64 | `cyne-linux-aarch64` | ✅ Available |
| Windows | x86_64 | `cyne-windows-x86_64.exe` | ✅ Available |
| macOS | x86_64/ARM64 | - | ❌ Not yet available |

## Supported LLM Providers

- OpenAI (GPT-4, GPT-3.5)
- Anthropic (Claude)
- Google (Gemini)
- Mistral AI
- Groq
- Cohere
- Fireworks AI
- Together AI

## Usage Examples

```bash
# Start interactive mode
cyne

# Run a single command
cyne "Create a Python script to parse CSV files"

# Use specific environment file
cyne -e .env.production

# Help
cyne --help
```

## Features

- 🤖 **ReAct Architecture**: Reasoning and Acting loop for complex task solving
- 🔧 **Multiple Tools**: File operations, bash execution, web search, planning
- 💾 **Persistent Memory**: Saves conversation history and plans
- 🎨 **Rich UI**: Beautiful terminal interface with syntax highlighting
- 🔐 **Human-in-the-Loop**: Approval system for critical operations
- 🌐 **Multi-Provider**: Seamlessly switch between LLM providers

## Building from Source

If you prefer to build from source or need a different platform:

```bash
# Install from PyPI
pip install cyne-cli

# Or clone and install
git clone https://github.com/CYNERZA/cyne-cli.git
cd cyne-cli
pip install -e .
```

See [CYNERZA/cyne-cli](https://github.com/CYNERZA/cyne-cli) for development documentation.

## Troubleshooting

### Permission Denied (Linux/macOS)
```bash
chmod +x cyne-linux-*
```

### Command Not Found
Ensure the binary is in your PATH or use the full path:
```bash
./cyne-linux-x86_64
```

### Missing Libraries (Linux)
The binaries are statically compiled with most dependencies, but if you encounter issues:
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install -y libglib2.0-0

# Alpine/Termux
apk add gcompat
```

## Version History

See [Releases](https://github.com/CYNERZA/cyne-bin/releases) for changelog and version history.

## Support & Documentation

- 📦 **PyPI Package**: [cyne-cli](https://pypi.org/project/cyne-cli/)
- 📖 **Source Code**: [CYNERZA/cyne-cli](https://github.com/CYNERZA/cyne-cli)
- 🐛 **Issues**: [Report bugs](https://github.com/CYNERZA/cyne-cli/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/CYNERZA/cyne-cli/discussions)

## License

MIT License - see [LICENSE](https://github.com/CYNERZA/cyne-cli/blob/main/LICENSE) for details.

---

**Note**: These are standalone binaries that don't require Python installation. Download, make executable, and run!
