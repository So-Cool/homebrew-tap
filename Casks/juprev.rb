cask "juprev" do
  # Placeholder until the first release:
  # scripts/release.sh in So-Cool/JuPrev prints the version and sha256 to put
  # here.
  version "0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

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
    # Launching once registers the Quick Look preview and thumbnail extensions;
    # --register-only makes the app quit straight away.
    run "/usr/bin/open",
        args: ["-g", "{{appdir}}/JuPrev.app", "--args", "--register-only"],
        must_succeed: false
    # The thumbnail service only notices new thumbnail extensions when it
    # restarts;
    # MacOS relaunches it on demand.
    run "/usr/bin/pkill",
        args:         ["-f", "com.apple.quicklook.ThumbnailsAgent"],
        must_succeed: false
  end

  uninstall quit: "me.kcpr.juprev"

  zap trash: [
    "~/Library/Application Support/JuPrev",
    "~/Library/Containers/me.kcpr.juprev",
    "~/Library/Containers/me.kcpr.juprev.quicklook",
    "~/Library/Containers/me.kcpr.juprev.thumbnail",
    "~/Library/Saved Application State/me.kcpr.juprev.savedState",
  ]
end
