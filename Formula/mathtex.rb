class Mathtex < Formula
  # Updated by the release workflow of So-Cool/MathTeX on each release.
  desc "Render LaTeX equations from the terminal to PDF, PNG or SVG"
  homepage "https://github.com/So-Cool/MathTeX"
  url "https://github.com/So-Cool/MathTeX/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "BSD-3-Clause"

  depends_on :macos         # pbpaste and osascript for the clipboard
  depends_on "imagemagick"  # PNG output
  depends_on "pdf2svg"      # SVG output

  def install
    bin.install "mathtex"
  end

  # LaTeX is a cask, and a formula cannot depend on a cask.
  def caveats
    <<~EOS
      MathTeX needs LaTeX, which Homebrew installs as a cask:
        brew install --cask mactex-no-gui
      or, for a smaller install, BasicTeX plus the packages MathTeX uses:
        brew install --cask basictex
        sudo tlmgr update --self
        sudo tlmgr install standalone varwidth xcolor
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mathtex -v").strip
  end
end
