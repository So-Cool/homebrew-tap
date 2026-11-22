cask "hot-cpu" do
  # Version, sha256 and asset ID in the URL are updated by the release
  # workflow of So-Cool/hot-cpu on each release.
  version "1.0"
  sha256 "06614e1da62ffc74c6d88d614d478c99bdb729f8d2382c74eba303026c9f3a40"

  # So-Cool/hot-cpu is private so the zip is downloaded through the GitHub API:
  # export HOMEBREW_GITHUB_API_TOKEN, a token that can read that repository,
  # before installing or upgrading.
  url "https://api.github.com/repos/So-Cool/hot-cpu/releases/assets/779555016",
      header: [
        "Accept: application/octet-stream",
        "Authorization: Bearer #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")}",
        "X-GitHub-Api-Version: 2022-11-28",
      ]
  name "Hot CPU"
  desc "Shows the CPU load or temperature with animated skins"
  homepage "https://github.com/So-Cool/hot-cpu"

  depends_on macos: :sonoma

  app "Hot CPU.app"

  # The app is ad-hoc signed, not notarized: without this, Gatekeeper refuses
  # to open it.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Hot CPU.app"]
  end

  uninstall quit: "me.kcpr.hot-cpu"

  # The config and the skins in ~/.config/hot-cpu are left alone:
  # they may be symlinks to a dotfiles repository.
  zap trash: "~/Library/Preferences/me.kcpr.hot-cpu.plist"
end
