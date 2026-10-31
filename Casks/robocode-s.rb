# SPDX-License-Identifier: EPL-2.0
#
# Homebrew cask template for robocode-s: `release.sh cask VERSION`
# fills in the version and the checksums of target/release-dist/VERSION/SHA256SUMS. It
# belongs in a tap of its own (a repository homebrew-robocode-s with Casks/robocode-s.rb), after
# the GitHub release v0.2.4 exists: `brew install --cask nhofsted/robocode-s/robocode-s`.
cask "robocode-s" do
  version "0.2.4"

  on_arm do
    sha256 "c342b33d44addc2e6eaa6fc6be4f435985b7ff8dca935ea061ad16b1390da0af"
    url "https://github.com/nhofsted/robocode-s/releases/download/v#{version}/robocode-s-#{version}-macos-aarch64.app.zip"
  end
  on_intel do
    sha256 "2b1cc057267a2779b3a7ff216d50836db5511191f115851ad4bedc3b9b03d3a9"
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
