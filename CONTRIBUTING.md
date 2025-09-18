# Contributing to Yaklang Yakit Homebrew Tap

## 🎯 Overview

This repository provides Homebrew Cask support for Yakit installation and automates the contribution process to the official homebrew-cask repository.

## 📁 Repository Structure

```
homebrew-yakit/
├── Casks/
│   ├── yakit.rb           # Local development cask with advanced features
│   ├── yakit-upstream.rb  # Standard cask for homebrew-cask submission
│   ├── yakit-arm64.rb     # Legacy ARM64-specific cask
│   └── yakit-x64.rb       # Legacy x64-specific cask
├── .github/workflows/
│   └── update-yakit.yml   # Automated version updates and testing
├── latest-version.txt     # Current latest version
├── history-versions.txt   # Version history with dates
└── test-scripts/          # Validation and testing scripts
```

## 🔄 Automated Workflow

### Daily Version Checking

The GitHub Actions workflow automatically:

1. **Fetches latest version** from GitHub Releases API
2. **Updates version files** if newer version found
3. **Tests installation** on macOS with real Homebrew
4. **Validates cask syntax** using `brew audit --cask --strict`
5. **Prepares upstream PR** for homebrew-cask
6. **Commits changes** to the main branch

### Two Cask Versions

#### Local Development (`yakit.rb`)
- Advanced features like environment variable version selection
- Local version file reading for stability
- Development and testing features

#### Upstream Standard (`yakit-upstream.rb`)
- Standard homebrew-cask format
- Simplified architecture detection using `Hardware::CPU.intel?`
- Compliant with homebrew-cask contribution guidelines

## 🧪 Testing

### Local Testing

```bash
# Test version detection
./validate-github-integration.sh

# Test installation scenarios
./test-versions.sh

# Manual cask testing
brew audit --cask --strict Casks/yakit-upstream.rb
brew install --cask ./Casks/yakit-upstream.rb --dry-run
```

### CI Testing

The macOS runner automatically:
- Validates cask syntax with strict checking
- Performs dry-run installation
- Tests actual installation and app verification
- Cleans up test installations

## 🍺 Contributing to homebrew-cask

### Automatic Process

The workflow prepares everything for upstream contribution:

1. **Version Update Detected** → Workflow triggers
2. **Local Testing** → Validates on macOS
3. **Upstream Preparation** → Creates branch in homebrew-cask format
4. **Manual Steps** → Follow workflow output for PR creation

### Manual Steps

After successful workflow run:

1. **Fork homebrew-cask** repository if not done already
2. **Add your fork** as remote to the prepared branch
3. **Push branch** to your fork
4. **Create PR** from your fork to `Homebrew/homebrew-cask`

### PR Guidelines

Follow these practices for upstream PRs:

- **Commit Message**: Use format `yakit: update to X.X.X`
- **Description**: Include testing verification and architecture support
- **Verification**: Mention macOS testing and brew audit passing
- **Documentation**: Reference this repository for maintenance

## 🔧 Development

### Setting Up

1. **Clone repository**:
   ```bash
   git clone https://github.com/yaklang/homebrew-yakit.git
   cd homebrew-yakit
   ```

2. **Configure GitHub token** (for automation):
   - Go to Repository Settings → Secrets → Actions
   - Add `GH_TOKEN` with `repo` and `workflow` scopes

3. **Test locally**:
   ```bash
   brew tap yaklang/yakit
   brew install yakit
   ```

### Version Management

#### Manual Version Update

1. **Update files**:
   ```bash
   echo "1.4.5-0920" > latest-version.txt
   echo "1.4.5-0920|$(date +%Y-%m-%d)|manual" >> history-versions.txt
   ```

2. **Update cask files**:
   ```bash
   sed -i.bak 's/version "[^"]*"/version "1.4.5-0920"/' Casks/yakit-upstream.rb
   ```

3. **Test and commit**:
   ```bash
   brew audit --cask --strict Casks/yakit-upstream.rb
   git add . && git commit -m "chore: update to 1.4.5-0920"
   ```

#### Automatic Updates

The workflow handles everything automatically:
- Monitors GitHub releases daily at 8:00 AM UTC
- Can be manually triggered from Actions tab
- Updates all version files and cask definitions

## 🔍 Troubleshooting

### Common Issues

1. **Cask Validation Fails**:
   ```bash
   brew audit --cask --strict Casks/yakit-upstream.rb
   ```

2. **Installation Test Fails**:
   ```bash
   brew install --cask ./Casks/yakit-upstream.rb --dry-run
   ```

3. **Version Detection Issues**:
   ```bash
   curl -s "https://api.github.com/repos/yaklang/yakit/releases/latest"
   ```

### Workflow Debugging

- Check Actions tab for detailed logs
- Review individual step outputs
- Validate token permissions for private operations
- Ensure macOS runner has required tools

## 📋 Checklist for Contributors

### For Version Updates

- [ ] Version detected from official sources
- [ ] All version files updated consistently
- [ ] Cask syntax validation passes
- [ ] Installation testing successful on macOS
- [ ] Upstream cask format compliance verified
- [ ] Commit messages follow conventional format

### For Code Changes

- [ ] Local testing completed
- [ ] CI passes all validation steps
- [ ] Documentation updated if needed
- [ ] Breaking changes documented
- [ ] Backward compatibility considered

## 🎯 Quality Standards

### Cask Requirements

- **Syntax**: Must pass `brew audit --cask --strict`
- **Installation**: Must install successfully on macOS
- **Architecture**: Support both ARM64 and Intel
- **Cleanup**: Proper app placement and zap trash
- **Livecheck**: Functional version checking

### Automation Standards

- **Reliability**: Handle network failures gracefully
- **Testing**: Comprehensive validation before changes
- **Rollback**: Safe failure modes without breaking state
- **Monitoring**: Clear logging and error reporting

## 📞 Support

- **Issues**: Open GitHub issue for bugs or questions
- **Discussions**: Use GitHub Discussions for general questions
- **Security**: Email security issues privately
- **Upstream**: Follow homebrew-cask guidelines for upstream issues

## 📄 License

This project follows the same license as the main Yakit project (AGPL-3.0).

---

**Happy Contributing!** 🍺
