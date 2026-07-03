  class BppLint < Formula
    desc "Linter for BPP (Bayesian Phylogenetics & Phylogeography) control files"
    homepage "https://github.com/bpp/bpp-lint"
    url "https://github.com/bpp/bpp-lint/archive/refs/tags/v0.2.1.tar.gz"
    sha256 "139a2212c94726a1254eef69b0f93668e9765f9d19dd9053fe45dcaf4ebc650a"
    license "AGPL-3.0-or-later"
    head "https://github.com/bpp/bpp-lint.git", branch: "main"

    def install
      system "make"
      bin.install "bpp-lint"
      pkgshare.install "examples"
      doc.install "README.md"
    end

    test do
      assert_match "bpp-lint", shell_output("#{bin}/bpp-lint --version")
      # clean fixture should exit 0
      system bin/"bpp-lint", pkgshare/"examples/modern-4x.bpp.ctl"
      # legacy fixture should exit 1 with the rename diagnostic
      output = shell_output("#{bin}/bpp-lint #{pkgshare}/examples/legacy-3x.bpp.ctl 2>&1", 1)
      assert_match "is now 'jobname'", output
    end
  end
