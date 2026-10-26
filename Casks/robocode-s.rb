# SPDX-License-Identifier: EPL-2.0
#
# Homebrew cask template for robocode-s: `release.sh cask VERSION`
# fills in the version and the checksums of target/release-dist/VERSION/SHA256SUMS. It
# belongs in a tap of its own (a repository homebrew-robocode-s with Casks/robocode-s.rb), after
# the GitHub release v0.2.3 exists: `brew install --cask nhofsted/robocode-s/robocode-s`.
cask "robocode-s" do
  version "0.2.3"

  on_arm do
    sha256 "e7121f31273c4b404317c30de237f4b00e49dccbd75a34be967bd37419f12874"
    url "https://github.com/nhofsted/robocode-s/releases/download/v#{version}/robocode-s-#{version}-macos-aarch64.app.zip"
  end
  on_intel do
    sha256 "d3f70668cce38cdc46483244860b43433a7cec45a368a5bd6d02a789c1b5f9ca"
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
