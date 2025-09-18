#!/bin/bash

# 测试 GitHub Actions workflow 中的 cask 生成逻辑
# 模拟 workflow 的版本化 cask 创建过程

set -e

echo "🧪 Testing Cask Generation Logic"
echo "================================"

# 模拟从 workflow 获取的版本
LATEST_VERSION="1.4.5-1025"

echo "📋 Testing with version: $LATEST_VERSION"

# 提取版本号部分和日期部分
VERSION_PART=$(echo "$LATEST_VERSION" | cut -d'-' -f1)
DATE_PART=$(echo "$LATEST_VERSION" | cut -d'-' -f2)

echo "Version part: $VERSION_PART"
echo "Date part: $DATE_PART"

# 使用完整版本号（包含日期）作为 cask 名称
VERSIONED_CASK="Casks/yakit@$LATEST_VERSION.rb"

# 格式化日期显示（1025 -> 2025-10-25）
YEAR="2025"
MONTH="${DATE_PART:0:2}"
DAY="${DATE_PART:2:2}"
FORMATTED_DATE="$YEAR-$MONTH-$DAY"

echo "Formatted date: $FORMATTED_DATE"
echo "Cask file: $VERSIONED_CASK"

# 检查版本化 cask 是否已存在
if [ ! -f "$VERSIONED_CASK" ]; then
  echo ""
  echo "🔨 Creating test versioned cask: $VERSIONED_CASK"
  
  # 创建版本化 cask 文件内容
  echo "cask \"yakit@$LATEST_VERSION\" do" > "$VERSIONED_CASK"
  echo "  version \"$LATEST_VERSION\"" >> "$VERSIONED_CASK"
  echo "  sha256 :no_check" >> "$VERSIONED_CASK"
  echo "" >> "$VERSIONED_CASK"
  echo "  name \"Yakit\"" >> "$VERSIONED_CASK"
  echo "  desc \"Cyber Security ALL-IN-ONE Platform (Release Date: $FORMATTED_DATE)\"" >> "$VERSIONED_CASK"
  echo "  homepage \"https://github.com/yaklang/yakit\"" >> "$VERSIONED_CASK"
  echo "" >> "$VERSIONED_CASK"
  echo "  # 根据架构选择不同的下载 URL" >> "$VERSIONED_CASK"
  echo "  on_arm do" >> "$VERSIONED_CASK"
  echo "    url \"https://oss-qn.yaklang.com/yak/#{version}/Yakit-#{version}-darwin-arm64.dmg\"" >> "$VERSIONED_CASK"
  echo "  end" >> "$VERSIONED_CASK"
  echo "" >> "$VERSIONED_CASK"
  echo "  on_intel do" >> "$VERSIONED_CASK"
  echo "    url \"https://oss-qn.yaklang.com/yak/#{version}/Yakit-#{version}-darwin-x64.dmg\"" >> "$VERSIONED_CASK"
  echo "  end" >> "$VERSIONED_CASK"
  echo "" >> "$VERSIONED_CASK"
  echo "  app \"Yakit.app\"" >> "$VERSIONED_CASK"
  echo "" >> "$VERSIONED_CASK"
  echo "  zap trash: [" >> "$VERSIONED_CASK"
  echo "    \"~/Library/Application Support/yakit\"," >> "$VERSIONED_CASK"
  echo "    \"~/Library/Preferences/com.yaklang.yakit.plist\"," >> "$VERSIONED_CASK"
  echo "    \"~/Library/Saved Application State/com.yaklang.yakit.savedState\"," >> "$VERSIONED_CASK"
  echo "  ]" >> "$VERSIONED_CASK"
  echo "" >> "$VERSIONED_CASK"
  echo "  caveats do" >> "$VERSIONED_CASK"
  echo "    <<~EOS" >> "$VERSIONED_CASK"
  echo "      This is Yakit version #{version} (Released: $FORMATTED_DATE)." >> "$VERSIONED_CASK"
  echo "      For the latest version, use: brew install yaklang/yakit" >> "$VERSIONED_CASK"
  echo "      " >> "$VERSIONED_CASK"
  echo "      Note: Only one version of Yakit can be installed at a time." >> "$VERSIONED_CASK"
  echo "      To switch versions, uninstall the current version first:" >> "$VERSIONED_CASK"
  echo "        brew uninstall --cask yakit" >> "$VERSIONED_CASK"
  echo "    EOS" >> "$VERSIONED_CASK"
  echo "  end" >> "$VERSIONED_CASK"
  echo "end" >> "$VERSIONED_CASK"
  
  echo "✅ Created $VERSIONED_CASK"
  
  echo ""
  echo "📄 Generated cask content:"
  echo "========================="
  cat "$VERSIONED_CASK"
  
  echo ""
  echo "🔍 Syntax validation:"
  if command -v brew >/dev/null 2>&1; then
    echo "Setting up temporary tap for testing..."
    # 创建临时目录结构
    TEMP_TAP_DIR=$(mktemp -d)
    mkdir -p "$TEMP_TAP_DIR/Casks"
    cp "$VERSIONED_CASK" "$TEMP_TAP_DIR/Casks/"
    
    # 添加临时 tap
    brew tap --force-auto-update homebrew/test-yakit "file://$TEMP_TAP_DIR"
    
    echo "Running: brew audit --cask homebrew/test-yakit/yakit@$LATEST_VERSION"
    if brew audit --cask --strict "homebrew/test-yakit/yakit@$LATEST_VERSION" 2>/dev/null; then
      echo "✅ Strict cask audit passed!"
    elif brew audit --cask "homebrew/test-yakit/yakit@$LATEST_VERSION" 2>/dev/null; then
      echo "✅ Basic cask audit passed!"
    else
      echo "⚠️  Cask audit failed, checking Ruby syntax..."
      if ruby -c "$VERSIONED_CASK" >/dev/null 2>&1; then
        echo "✅ Ruby syntax is valid (audit may fail due to missing dependencies)"
      else
        echo "❌ Ruby syntax error detected"
      fi
    fi
    
    # 清理临时 tap
    brew untap homebrew/test-yakit 2>/dev/null || true
    rm -rf "$TEMP_TAP_DIR"
  else
    echo "⚠️  Homebrew not available, running Ruby syntax check..."
    if ruby -c "$VERSIONED_CASK" >/dev/null 2>&1; then
      echo "✅ Ruby syntax is valid"
    else
      echo "❌ Ruby syntax error detected"
    fi
  fi
  
  echo ""
  echo "🧹 Cleanup test file..."
  read -p "Delete test file $VERSIONED_CASK? (y/N): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm "$VERSIONED_CASK"
    echo "🗑️  Deleted test file"
  else
    echo "📁 Keeping test file for review"
  fi
  
else
  echo "ℹ️  Versioned cask already exists: $VERSIONED_CASK"
fi

echo ""
echo "🎉 Cask generation test completed!"
