# SPDX-License-Identifier: EPL-2.0
#
# Homebrew cask template for robocode-s: `release.sh cask VERSION`
# fills in the version and the checksums of target/release-dist/VERSION/SHA256SUMS. It
# belongs in a tap of its own (a repository homebrew-robocode-s with Casks/robocode-s.rb), after
# the GitHub release v0.2.1 exists: `brew install --cask nhofsted/robocode-s/robocode-s`.
cask "robocode-s" do
  version "0.2.1"

  on_arm do
    sha256 "f619a104cfe3d62aa4fdfe0538aaea9226fc8424e9d02cc0d3b03baa22cff22b"
    url "https://github.com/nhofsted/robocode-s/releases/download/v#{version}/robocode-s-#{version}-macos-aarch64.app.zip"
  end
  on_intel do
    sha256 "2391002fbf78d0e4497fa76c5bb47c847e7f926d2b59c12bd34fd4b76e493bab"
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
