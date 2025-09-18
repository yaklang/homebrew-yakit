# Yaklang Yakit

## Installation

### Quick Install

```bash
brew install yaklang/yakit
```

This will automatically detect your system architecture (ARM64/M1/M2 or Intel) and install the default version (1.4.4-0912) of Yakit.

### Version Selection

You can install different versions of Yakit using multiple methods:

#### Install Latest Version (Default)
```bash
brew install yaklang/yakit
# or explicitly
YAKIT_VERSION=latest brew install --cask yaklang/yakit
```

#### Install Specific Version by Version Number
```bash
# Using environment variable
YAKIT_VERSION=1.4.3-0801 brew install --cask yaklang/yakit

# Using versioned cask (recommended)
brew install --cask yaklang/yakit@1.4.4-0912
brew install --cask yaklang/yakit@1.4.3-0801
brew install --cask yaklang/yakit@1.4.2-0705
```

#### Install Remote Latest Version
```bash
# Bypass local cache and fetch from remote URL
YAKIT_VERSION=remote brew install --cask yaklang/yakit
```

#### Available Versioned Casks

- `yakit@1.4.4-0912` - Latest version (Released: 2025-09-12)
- `yakit@1.4.3-0801` - Previous version (Released: 2025-08-01)  
- `yakit@1.4.2-0705` - Older version (Released: 2025-07-05)

#### Version Management

```bash
# List available versions
brew search yaklang/yakit

# Check installed version
brew list --cask | grep yakit

# Switch versions (uninstall current first)
brew uninstall --cask yakit
brew install --cask yaklang/yakit@1.4.3-0801
```

> **💡 Version Format**: Yakit uses date-based versioning: `X.Y.Z-MMDD` where `MMDD` represents the release month and day.
>
> **📦 Local Version Files**: The main installer reads version information from local files (`latest-version.txt`) for improved stability and faster installation.

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
- ✅ **CI/CD Integration**: macOS runner for stable Homebrew testing
- ✅ **Upstream Ready**: Automated PR preparation for homebrew-cask

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

### Version Files

The repository maintains local version files for stability and reliability:

- **`latest-version.txt`**: Contains the current latest version number
- **`history-versions.txt`**: Maintains version history with dates and sources
- **`Casks/yakit.rb`**: Local development cask with advanced features
- **`Casks/yakit-upstream.rb`**: Standard cask for homebrew-cask upstream submission

**Data Sources:**
- Primary: [GitHub Releases API](https://api.github.com/repos/yaklang/yakit/releases/latest)
- Backup: `https://oss-qn.yaklang.com/yak/latest/yakit-version.txt`

### Workflow Details

The automation workflow (`.github/workflows/update-yakit.yml`):
1. **Fetches latest version** from GitHub Releases API (with backup fallback)
2. **Compares versions** with local `latest-version.txt` file
3. **Updates version files** if newer version is found:
   - Updates `latest-version.txt` with new version
   - Adds entry to `history-versions.txt` with date and source
   - Updates `yakit-upstream.rb` for homebrew-cask submission
4. **Tests installation** on macOS runner with actual Homebrew
5. **Validates cask syntax** using `brew audit --cask --strict`
6. **Prepares upstream PR** to homebrew-cask repository
7. **Auto-commits and pushes** changes to main branch

**Version Detection Logic:**
- Primary: GitHub API (`/repos/yaklang/yakit/releases/latest`)
- Fallback: Direct URL (`oss-qn.yaklang.com/yak/latest/yakit-version.txt`)
- Local: Version files in repository

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
