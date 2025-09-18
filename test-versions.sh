#!/bin/bash

# Yakit 版本安装测试脚本
# 用于测试本地版本文件系统的安装方式

set -e

echo "🧪 Yakit Version Installation Test Script"
echo "========================================="
echo "📁 Using Local Version Files System"
echo ""

# 设置代理（如果需要）
if [ ! -z "$http_proxy" ]; then
    echo "📡 Using proxy: $http_proxy"
    export http_proxy=$http_proxy
    export https_proxy=$https_proxy
fi

echo "📋 Current Version Files:"
echo "Latest version: $(cat latest-version.txt 2>/dev/null || echo 'Not found')"
echo "History file exists: $([ -f history-versions.txt ] && echo '✅' || echo '❌')"
echo ""

echo "1️⃣ 测试默认版本安装 (从本地文件读取)"
echo "------------------------------------"
echo "Command: brew install --cask yaklang/yakit"
echo "Expected: Read version from latest-version.txt and install"

echo ""
echo "2️⃣ 测试最新版本安装 (显式指定)"
echo "-------------------------------"
echo "Command: YAKIT_VERSION=latest brew install --cask yaklang/yakit"
echo "Expected: Same as default, read from latest-version.txt"

echo ""
echo "3️⃣ 测试指定版本安装"
echo "--------------------"
echo "Command: YAKIT_VERSION=1.4.3-0801 brew install --cask yaklang/yakit"
echo "Expected: Install specific version 1.4.3-0801"

echo ""
echo "📊 本地版本文件检查:"
echo "Current latest-version.txt: $(cat latest-version.txt 2>/dev/null || echo 'Not found')"
echo "Version history:"
if [ -f history-versions.txt ]; then
    tail -5 history-versions.txt
else
    echo "No history file found"
fi

echo ""
echo "🔍 远程版本检查:"
REMOTE_VERSION=$(curl -s "https://oss-qn.yaklang.com/yak/latest/yakit-version.txt" 2>/dev/null || echo 'Connection failed')
echo "Remote latest version: $REMOTE_VERSION"

echo ""
echo "⚠️  注意事项:"
echo "- 确保已安装并配置了 yaklang/yakit tap"
echo "- 本地文件版本可能与远程版本不同（这是正常的）"
echo "- 如果安装失败，检查网络连接和代理设置"
echo "- 测试前可以先卸载现有版本: brew uninstall --cask yaklang/yakit"

echo ""
echo "🎯 测试命令:"
echo "brew info --cask yaklang/yakit  # 查看已安装版本信息"
echo "./test-versions.sh             # 重新运行此测试脚本"

echo ""
echo "✅ 准备就绪！请逐个测试上述命令。"
