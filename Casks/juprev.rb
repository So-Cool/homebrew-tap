cask "juprev" do
  # Version and sha256 are updated by the release workflow of So-Cool/JuPrev
  # on each release.
  version "0.1"
  sha256 "81e2793c4ee752446b30d30a468c1ec94eafe159e7aa98921dc020388554629c"

  url "https://github.com/So-Cool/JuPrev/releases/download/v#{version}/JuPrev-#{version}.zip"
  name "JuPrev"
  desc "Minimal viewer and Quick Look preview for Jupyter Notebooks"
  homepage "https://github.com/So-Cool/JuPrev"

  depends_on macos: :sonoma

  app "JuPrev.app"

  postflight_steps do
    # The app is ad-hoc signed, not notarized:
    # without this, Gatekeeper refuses to open it.
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/JuPrev.app"]
  end

  # Steps run in Homebrew's sandbox, which can't launch apps or signal
  # processes, so the user has to register the extensions and restart the
  # thumbnail service.
  caveats <<~EOS
    Open JuPrev once after installing or upgrading:
    that registers its Quick Look previews and Finder thumbnails.
    Thumbnails of a fresh install appear after you log out and back in
    or straight away after running:
      pkill -f com.apple.quicklook.ThumbnailsAgent
  EOS

  uninstall quit: "me.kcpr.juprev"

  zap trash: [
    "~/Library/Application Support/JuPrev",
    "~/Library/Containers/me.kcpr.juprev",
    "~/Library/Containers/me.kcpr.juprev.quicklook",
    "~/Library/Containers/me.kcpr.juprev.thumbnail",
    "~/Library/Saved Application State/me.kcpr.juprev.savedState",
  ]
end
