class GnostrGui < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.33"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.33/gnostr-gui-x86_64-apple-darwin.tar.gz"
    sha256 "c3a29184dd5445ce1cc4d1e078657410212f4bd0a8c1cabad55a0cced73e3f4d"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.33/gnostr-gui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3665f265931f03d1b646b3c77087faf687cb5967cadd41546bd868fae3535147"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "gnostr-gui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-gui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-gui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
