class Readtime < Formula
  # Updated by the release workflow of So-Cool/readtime on each release.
  # Placeholder until the first release (tag v0.1):
  # the url and sha256 below are overwritten by that workflow,
  # so the formula is not installable before.
  desc "Estimate the reading time of Markdown, Quarto, LaTeX and Typst files"
  homepage "https://github.com/So-Cool/readtime"
  url "https://github.com/So-Cool/readtime/archive/refs/tags/v0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "BSD-3-Clause"

  depends_on "git"     # only tracked files are counted in a git repository
  depends_on "pandoc"  # converts the documents for the readtime.lua filter

  uses_from_macos "ncurses"  # tput and clear

  # --watch
  on_macos do
    depends_on "fswatch"
  end
  on_linux do
    depends_on "inotify-tools"
  end

  def install
    bin.install "readtime"
    pkgshare.install "readtime.lua"  # found by readtime in ../share/readtime/
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/readtime --version").strip
    (testpath/"test.md").write "Some words to count.\n"
    assert_equal "test.md: 1m (4w)", shell_output("#{bin}/readtime --compact test.md").lines.first.chomp
  end
end
