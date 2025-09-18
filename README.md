# Yaklang Yakit

## Installation

### Quick Install

```bash
brew install yaklang/yakit
```

This will automatically detect your system architecture (ARM64/M1/M2 or Intel) and install the default version (1.4.4-0912) of Yakit.

### Version Selection

You can install different versions of Yakit using environment variables:

#### Install Latest Version
```bash
YAKIT_VERSION=latest brew install --cask yaklang/yakit
```

#### Install Specific Version
```bash
YAKIT_VERSION=1.4.3-0801 brew install --cask yaklang/yakit
```

#### Install Default Version (1.4.4-0912)
```bash
brew install yaklang/yakit
# or
YAKIT_VERSION=1.4.4-0912 brew install --cask yaklang/yakit
```

### Alternative Installation Methods

First tap the repository:

```bash
brew tap yaklang/yakit
```

Then install:

```bash
brew install yakit
```

## Features

- ✅ **Multi-Architecture Support**: Automatically detects ARM64 (M1/M2) or Intel chips
- ✅ **Version Flexibility**: Support for latest, specific, or default versions
- ✅ **Auto Updates**: Built-in livecheck for version updates
- ✅ **Clean Uninstall**: Includes zap stanza for complete removal

## What is Yakit?

Yakit is a Cyber Security ALL-IN-ONE Platform developed by Yaklang. It provides comprehensive tools for security testing and analysis.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
