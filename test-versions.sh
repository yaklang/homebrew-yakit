#!/bin/bash

# Yakit 版本安装测试脚本
# 用于测试不同版本的安装方式

set -e

echo "🧪 Yakit Version Installation Test Script"
echo "========================================"

# 设置代理（如果需要）
if [ ! -z "$http_proxy" ]; then
    echo "📡 Using proxy: $http_proxy"
    export http_proxy=$http_proxy
    export https_proxy=$https_proxy
fi

echo ""
echo "1️⃣ 测试默认版本安装 (1.4.4-0912)"
echo "--------------------------------"
echo "Command: brew install --cask yaklang/yakit"
echo "Expected: Install version 1.4.4-0912"

echo ""
echo "2️⃣ 测试最新版本安装"
echo "---------------------"
echo "Command: YAKIT_VERSION=latest brew install --cask yaklang/yakit"
echo "Expected: Fetch and install latest version from URL"

echo ""
echo "3️⃣ 测试指定版本安装"
echo "--------------------"
echo "Command: YAKIT_VERSION=1.4.3-0801 brew install --cask yaklang/yakit"
echo "Expected: Install specific version 1.4.3-0801"

echo ""
echo "📋 版本验证命令:"
echo "brew info --cask yaklang/yakit"

echo ""
echo "🔍 检查版本号来源:"
echo "curl -s https://oss-qn.yaklang.com/yak/latest/yakit-version.txt"

echo ""
echo "⚠️  注意事项:"
echo "- 确保已安装并配置了 yaklang/yakit tap"
echo "- 如果安装失败，检查网络连接和代理设置"
echo "- 测试前可以先卸载现有版本: brew uninstall --cask yaklang/yakit"

echo ""
echo "✅ 准备就绪！请逐个测试上述命令。"
