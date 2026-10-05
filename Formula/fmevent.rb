class Fmevent < Formula
  desc "Semantic if: branch on what text means, not on what it says"
  homepage "https://github.com/noinoiexists/fmevent"
  url "https://github.com/noinoiexists/fmevent/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "1297ef9200e70719a2af650e47aabbaf148cb2678cbba4370055ae5cdc82cbba"
  license "MIT"
  head "https://github.com/noinoiexists/fmevent.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on macos: :golden_gate

  def install
    bin.install "bin/fmevent"
    man1.install "man/man1/fmevent.1"
    doc.install "README.md", "LICENSE"
    pkgshare.install "examples"
  end

  def caveats
    <<~EOS
      fmevent needs the on-device model, which macOS downloads separately from
      the operating system itself. Check that everything is ready:

        fmevent doctor

      Then:

        man fmevent
        cat "#{pkgshare}/examples/README.md"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fmevent --version")
    assert_match "semantic", shell_output("#{bin}/fmevent --help")
  end
end
