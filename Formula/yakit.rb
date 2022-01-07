
   
# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Yakit < Formula
    homepage "https://github.com/yaklang/yakit"
    author "v1ll4n"

    depends_on "curl"
    depends_on "wget"
  
    def install
      # fetch latest yakit version
      system("export LATEST_YAKIT_VERSION=`curl -sS -L  https://yaklang.oss-cn-beijing.aliyuncs.com/yak/latest/yakit-version.txt`")
      system("wget https://yaklang.oss-cn-beijing.aliyuncs.com/yak/${LATEST_YAKIT_VERSION}/Yakit-${LATEST_YAKIT_VERSION}-darwin-arm64.dmg -O ~/Download")
      
    end
  
    test do
      system "false"
    end
  end