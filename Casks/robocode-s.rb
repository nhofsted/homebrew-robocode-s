# SPDX-License-Identifier: EPL-2.0
#
# Homebrew cask template for robocode-s: `release.sh cask VERSION`
# fills in the version and the checksums of target/release-dist/VERSION/SHA256SUMS. It
# belongs in a tap of its own (a repository homebrew-robocode-s with Casks/robocode-s.rb), after
# the GitHub release v0.1.0 exists: `brew install --cask nhofsted/robocode-s/robocode-s`.
cask "robocode-s" do
  version "0.1.0"

  on_arm do
    sha256 "a561fd2ca3996d7b7802ce2479127ad186352a49814b3de71a593f7b6ea93f80"
    url "https://github.com/nhofsted/robocode-s/releases/download/v#{version}/robocode-s-#{version}-macos-aarch64.app.zip"
  end
  on_intel do
    sha256 "57fa6aed7d1a46ee01d0ceed0cc43b89b2e91d0cf99cf6fbb4338fb2d50621f9"
    url "https://github.com/nhofsted/robocode-s/releases/download/v#{version}/robocode-s-#{version}-macos-x86_64.app.zip"
  end

  name "robocode-s"
  desc "Robocode battle engine and viewer"
  homepage "https://github.com/nhofsted/robocode-s"

  app "robocode-s.app"
  binary "#{appdir}/robocode-s.app/Contents/MacOS/robocode-s"

  # The app is not signed or notarized: without this Gatekeeper refuses it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/robocode-s.app"]
  end

  zap trash: [
    "~/Library/Application Support/robocode-s",
  ]
end
