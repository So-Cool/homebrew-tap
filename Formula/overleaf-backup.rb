class OverleafBackup < Formula
  include Language::Python::Shebang

  # Updated by the release workflow of So-Cool/overleaf-backup on each release.
  # Placeholder until the first release (tag v0.1):
  # the url and sha256 below are overwritten by that workflow, so the formula
  # is not installable before.
  desc "Back up Overleaf projects as local git repositories"
  homepage "https://github.com/So-Cool/overleaf-backup"
  url "https://github.com/So-Cool/overleaf-backup/archive/refs/tags/v0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "BSD-3-Clause"

  depends_on "python@3.15"  # needs Python 3.11 or newer (tomllib)

  def install
    rewrite_shebang detected_python_shebang, "overleaf-backup"
    bin.install "overleaf-backup"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/overleaf-backup --version").strip
  end
end
