cask "yakit@1.4.5-1128" do
  version "1.4.5-1128"
  sha256 :no_check

  name "Yakit"
  desc "Cyber Security ALL-IN-ONE Platform (Release Date: 2025-11-28)"
  homepage "https://github.com/yaklang/yakit"

  # 根据架构选择不同的下载 URL
  on_arm do
    url "https://oss-qn.yaklang.com/yak/#{version}/Yakit-#{version}-darwin-arm64.dmg"
  end

  on_intel do
    url "https://oss-qn.yaklang.com/yak/#{version}/Yakit-#{version}-darwin-x64.dmg"
  end

  app "Yakit.app"

  zap trash: [
    "~/Library/Application Support/yakit",
    "~/Library/Preferences/com.yaklang.yakit.plist",
    "~/Library/Saved Application State/com.yaklang.yakit.savedState",
  ]

  caveats do
    <<~EOS
      This is Yakit version #{version} (Released: 2025-11-28).
      For the latest version, use: brew install yaklang/yakit
      
      Note: Only one version of Yakit can be installed at a time.
      To switch versions, uninstall the current version first:
        brew uninstall --cask yakit
    EOS
  end
end
