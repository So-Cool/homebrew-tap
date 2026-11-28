cask "ia-writer" do
  # Version and sha256 are updated monthly by .github/workflows/bump-casks.yml.
  # The version is "<marketing version>,<build number>" given by the zip name.
  version "0,0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://files.ia.net/writer/release/iA-Writer-#{version.csv.first}-#{version.csv.second}.zip"
  name "iA Writer"
  desc "Focused Markdown editor (7-day trial)"
  homepage "https://ia.net/writer"

  livecheck do
    url "https://files.ia.net/writer/release/updates.xml"
    strategy :sparkle
  end

  # The app updates itself through Sparkle, so `brew upgrade` skips it
  # unless you pass --greedy;
  # the cask still follows each release.
  auto_updates true
  depends_on macos: :ventura

  app "iA Writer.app"

  uninstall quit: "pro.writer.mac"

  zap trash: [
    "~/Library/Application Scripts/pro.writer.mac",
    "~/Library/Containers/pro.writer.mac",
    "~/Library/Group Containers/*.pro.writer.mac",
  ]
end
