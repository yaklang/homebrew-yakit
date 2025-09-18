cask "yakit" do
  # 支持多种版本选择：
  # 1. 环境变量 YAKIT_VERSION=latest - 从 URL 获取最新版本
  # 2. 环境变量 YAKIT_VERSION=1.4.3-0801 - 指定特定版本
  # 3. 默认使用固定版本 1.4.4-0912
  version do
    requested_version = ENV["YAKIT_VERSION"]
    if requested_version == "latest"
      require "net/http"
      require "uri"
      begin
        url = URI.parse("https://oss-qn.yaklang.com/yak/latest/yakit-version.txt")
        response = Net::HTTP.get(url)
        response.strip
      rescue
        # 如果获取失败，使用默认版本
        "1.4.4-0912"
      end
    elsif requested_version && !requested_version.empty?
      requested_version
    else
      "1.4.4-0912"
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

  # 自动检查新版本
  livecheck do
    url "https://oss-qn.yaklang.com/yak/latest/yakit-version.txt"
    strategy :page_match
    regex(/^(.+)$/)
  end

  zap trash: [
    "~/Library/Application Support/yakit",
    "~/Library/Preferences/com.yaklang.yakit.plist",
    "~/Library/Saved Application State/com.yaklang.yakit.savedState",
  ]
end
