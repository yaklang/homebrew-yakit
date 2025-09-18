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

> **Note**: Homebrew doesn't support `brew install yakit@version` syntax. Use environment variables instead.

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
- ✅ **Auto Updates**: Built-in livecheck for version updates + GitHub Actions automation
- ✅ **Clean Uninstall**: Includes zap stanza for complete removal

## Automation

This repository includes automated version checking via GitHub Actions:

- **Daily Checks**: Runs every day at 8:00 AM UTC to check for new Yakit releases
- **Automatic PRs**: Creates pull requests when new versions are detected
- **Validation**: Verifies cask syntax and download URLs before creating PRs
- **Manual Trigger**: Can be manually triggered from GitHub Actions tab

### Setup

Before using the automation, you need to configure a GitHub token:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Click **"New repository secret"**
3. Name: `GH_TOKEN`
4. Value: Your [GitHub Personal Access Token](https://github.com/settings/tokens)
   - Required scopes: `repo`, `workflow`
5. Click **"Add secret"**

### Workflow Details

The automation workflow (`.github/workflows/update-yakit.yml`):
1. Fetches the latest version from the official Yakit version endpoint
2. Compares with the current version in the cask
3. Updates the cask file if a newer version is found
4. Validates the cask syntax
5. Creates a pull request for review

### Manual Update

You can also manually trigger the update workflow:
1. Go to the **Actions** tab in this repository
2. Select **"Update Yakit Version"** workflow
3. Click **"Run workflow"**
4. Optionally enable **"Force update"** to update even if versions match

## What is Yakit?

Yakit is a Cyber Security ALL-IN-ONE Platform developed by Yaklang. It provides comprehensive tools for security testing and analysis.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
