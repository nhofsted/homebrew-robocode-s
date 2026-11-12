# SPDX-License-Identifier: EPL-2.0
#
# Homebrew cask template for robocode-s: `release.sh cask VERSION`
# fills in the version and the checksums of target/release-dist/VERSION/SHA256SUMS. It
# belongs in a tap of its own (a repository homebrew-robocode-s with Casks/robocode-s.rb), after
# the GitHub release v0.2.7 exists: `brew install --cask nhofsted/robocode-s/robocode-s`.
cask "robocode-s" do
  version "0.2.7"

  on_arm do
    sha256 "dec1b8babbcedb8326220e974c4a11827167a44fbda4d4fc1ecbd3c218d03932"
    url "https://github.com/nhofsted/robocode-s/releases/download/v#{version}/robocode-s-#{version}-macos-aarch64.app.zip"
  end
  on_intel do
    sha256 "ebeefad9c5da8919e5066b199e596908dbd554469e7978368e81c5a878e6b9e6"
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
