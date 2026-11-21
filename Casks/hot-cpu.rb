cask "hot-cpu" do
  # Updated by the release workflow of So-Cool/hot-cpu on each release.
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/So-Cool/hot-cpu/releases/download/v#{version}/Hot-CPU-#{version}.zip"
  name "Hot CPU"
  desc "Shows the CPU load or temperature with animated skins"
  homepage "https://github.com/So-Cool/hot-cpu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Hot CPU.app"

  # The app is ad-hoc signed, not notarized: without this, Gatekeeper refuses
  # to open it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Hot CPU.app"]
  end

  uninstall quit: "me.kcp.hot-cpu"

  # The config and the skins in ~/.config/hot-cpu are left alone:
  # they may be symlinks to a dotfiles repository.
  zap trash: "~/Library/Preferences/me.kcp.hot-cpu.plist"
end
