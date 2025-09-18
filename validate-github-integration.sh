#!/bin/bash

# 验证 GitHub API 集成的脚本
# 用于测试版本获取和文件更新的功能

set -e

echo "🔍 GitHub Integration Validation Script"
echo "======================================"

# 设置代理（如果需要）
if [ ! -z "$http_proxy" ]; then
    echo "📡 Using proxy: $http_proxy"
fi

echo ""
echo "1️⃣ 测试 GitHub API 版本获取"
echo "----------------------------"
GITHUB_VERSION=$(curl -s "https://api.github.com/repos/yaklang/yakit/releases/latest" | grep '"tag_name"' | head -1 | sed -E 's/.*"tag_name": "([^"]+)".*/\1/' | sed 's/^v//')

if [ -n "$GITHUB_VERSION" ] && [ "$GITHUB_VERSION" != "null" ]; then
    echo "✅ GitHub API version: $GITHUB_VERSION"
else
    echo "❌ Failed to get version from GitHub API"
fi

echo ""
echo "2️⃣ 测试备份 URL 版本获取"
echo "-------------------------"
BACKUP_VERSION=$(curl -s "https://oss-qn.yaklang.com/yak/latest/yakit-version.txt" | tr -d '\n')

if [ -n "$BACKUP_VERSION" ]; then
    echo "✅ Backup URL version: $BACKUP_VERSION"
else
    echo "❌ Failed to get version from backup URL"
fi

echo ""
echo "3️⃣ 版本一致性检查"
echo "------------------"
if [ "$GITHUB_VERSION" = "$BACKUP_VERSION" ]; then
    echo "✅ Versions match: $GITHUB_VERSION"
else
    echo "⚠️  Versions differ:"
    echo "   GitHub API: $GITHUB_VERSION"
    echo "   Backup URL: $BACKUP_VERSION"
fi

echo ""
echo "4️⃣ 本地文件检查"
echo "----------------"
echo "Current latest-version.txt:"
if [ -f "latest-version.txt" ]; then
    cat latest-version.txt
else
    echo "❌ File not found"
fi

echo ""
echo "Recent history-versions.txt entries:"
if [ -f "history-versions.txt" ]; then
    tail -3 history-versions.txt
else
    echo "❌ File not found"
fi

echo ""
echo "5️⃣ Workflow 文件检查"
echo "--------------------"
if [ -f ".github/workflows/update-yakit.yml" ]; then
    echo "✅ Workflow file exists"
    if grep -q "api.github.com" .github/workflows/update-yakit.yml; then
        echo "✅ GitHub API integration found in workflow"
    else
        echo "❌ GitHub API integration missing"
    fi
else
    echo "❌ Workflow file not found"
fi

echo ""
echo "🎉 Validation complete!"
echo ""
echo "📋 Summary:"
echo "- GitHub API version: ${GITHUB_VERSION:-'N/A'}"
echo "- Backup URL version: ${BACKUP_VERSION:-'N/A'}"
echo "- Local version: $(cat latest-version.txt 2>/dev/null || echo 'N/A')"
echo "- Workflow status: $([ -f '.github/workflows/update-yakit.yml' ] && echo '✅' || echo '❌')"
