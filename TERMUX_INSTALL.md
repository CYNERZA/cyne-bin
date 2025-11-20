# Installing Cyne CLI on Termux (Android)

⚠️ **Important**: The precompiled binaries don't work on Termux due to Android's unique environment.

## Recommended Installation Method

Use pip to install directly in Termux:

```bash
# Update packages
pkg update && pkg upgrade

# Install Python and dependencies
pkg install python python-pip git build-essential binutils libffi openssl

# Install Cyne CLI
pip install cyne-cli

# Run
cyne
```

## Configuration

On first run, configure your API keys:

```bash
cyne

# Then in the CLI:
/config openai YOUR_API_KEY
/config anthropic YOUR_API_KEY
/config google YOUR_API_KEY
```

Or edit `~/.cyne/config.json` directly:
```json
{
  "openai_api_key": "sk-...",
  "anthropic_api_key": "sk-ant-...",
  "google_api_key": "AI..."
}
```

## Why Not Use Binaries?

Termux runs on Android with a different:
- File system structure (`/data/data/com.termux/...`)
- Dynamic linker and library paths
- Process execution model

PyInstaller binaries expect standard Linux environments and won't execute properly in Termux.

## Alternative: Build from Source

```bash
# Clone the repository
git clone https://github.com/CYNERZA/cyne-cli.git
cd cyne-cli

# Install in development mode
pip install -e .

# Run
cyne
```

## Troubleshooting

### Missing Dependencies
```bash
pkg install python-cryptography python-lxml
```

### Permission Issues
```bash
termux-setup-storage
```

### Slow Installation
Due to ARM compilation, some packages may take time. Be patient during pip install.

## Support

For Termux-specific issues, please open an issue at:
https://github.com/CYNERZA/cyne-cli/issues

Include your:
- Termux version: `termux-info`
- Python version: `python --version`
- Device architecture: `uname -m`
