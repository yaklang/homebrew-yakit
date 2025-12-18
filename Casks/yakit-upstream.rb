cask "yakit" do
  version "1.4.5-1212"
  sha256 :no_check

  url "https://oss-qn.yaklang.com/yak/#{version}/Yakit-#{version}-darwin-#{Hardware::CPU.intel? ? "x64" : "arm64"}.dmg"
  name "Yakit"
  desc "Cyber Security ALL-IN-ONE Platform"
  homepage "https://github.com/yaklang/yakit"

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
