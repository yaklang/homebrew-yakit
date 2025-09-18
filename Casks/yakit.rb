cask "yakit" do
  version "1.4.4-0912"
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
