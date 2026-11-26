cask "hotcpu" do
  # Version, sha256 and asset ID in the URL are updated by the release
  # workflow of So-Cool/hotcpu on each release.
  version "1.5"
  sha256 "6e11d50b889ed3e881e755596f12d8a9edde6423dbb0cca834021c74524bd81a"

  # So-Cool/hotcpu is private so the zip is downloaded through the GitHub API:
  # export HOMEBREW_GITHUB_API_TOKEN, a token that can read that repository,
  # before installing or upgrading.
  url "https://api.github.com/repos/So-Cool/hotcpu/releases/assets/795844859",
      header: [
        "Accept: application/octet-stream",
        "Authorization: Bearer #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")}",
        "X-GitHub-Api-Version: 2022-11-28",
      ]
  name "Hot CPU"
  desc "Shows the CPU load or temperature with animated skins"
  homepage "https://github.com/So-Cool/hotcpu"

  depends_on macos: :sonoma

  app "Hot CPU.app"

  # The app is ad-hoc signed, not notarized: without this, Gatekeeper refuses
  # to open it.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Hot CPU.app"]
  end

  uninstall quit: "me.kcpr.hotcpu"

  # The config and the skins in ~/.config/hotcpu are left alone:
  # they may be symlinks to a dotfiles repository.
  zap trash: "~/Library/Preferences/me.kcpr.hotcpu.plist"
end
