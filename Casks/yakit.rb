cask "yakit" do
  # 支持多种版本选择：
  # 1. 环境变量 YAKIT_VERSION=latest - 从本地 latest-version.txt 读取
  # 2. 环境变量 YAKIT_VERSION=1.4.3-0801 - 指定特定版本
  # 3. 默认从本地 latest-version.txt 读取最新版本
  version do
    requested_version = ENV["YAKIT_VERSION"]
    if requested_version == "latest" || requested_version.nil? || requested_version.empty?
      begin
        # 从本地 latest-version.txt 文件读取最新版本
        File.read(File.join(__dir__, "..", "latest-version.txt")).strip
      rescue
        # 如果读取失败，使用默认版本
        "1.4.4-0912"
      end
    elsif requested_version
      requested_version
    else
      begin
        File.read(File.join(__dir__, "..", "latest-version.txt")).strip
      rescue
        "1.4.4-0912"
      end
    end
  end

  sha256 :no_check

  name "Yakit"
  desc "Cyber Security ALL-IN-ONE Platform"
  homepage "https://github.com/yaklang/yakit"

  # 根据架构选择不同的下载 URL
  on_arm do
    url "https://oss-qn.yaklang.com/yak/#{version}/Yakit-#{version}-darwin-arm64.dmg"
  end

  on_intel do
    url "https://oss-qn.yaklang.com/yak/#{version}/Yakit-#{version}-darwin-x64.dmg"
  end

  app "Yakit.app"

  # 自动检查新版本（使用本地文件）
  livecheck do
    url "file://#{File.join(__dir__, "..", "latest-version.txt")}"
    strategy :page_match
    regex(/^(.+)$/)
  end

  zap trash: [
    "~/Library/Application Support/yakit",
    "~/Library/Preferences/com.yaklang.yakit.plist",
    "~/Library/Saved Application State/com.yaklang.yakit.savedState",
  ]
end
