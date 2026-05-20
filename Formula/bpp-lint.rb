  class BppLint < Formula
    desc "Linter for BPP (Bayesian Phylogenetics & Phylogeography) control files"
    homepage "https://github.com/bpp/bpp-lint"
    url "https://github.com/bpp/bpp-lint/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "59f60290399aa18291010b111034af8d511b5f980a031691b2e33e5600d888d4"
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
