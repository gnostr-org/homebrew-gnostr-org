class GnostrTui < Formula
  desc "blazing fast terminal-ui for git"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.43"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-tui-aarch64-apple-darwin.tar.gz"
      sha256 "cd69927e17d5e5692ba9039c0193287212ea65be973638bc5b90d74d84301af7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-tui-x86_64-apple-darwin.tar.gz"
      sha256 "0987ce4d8c6964d216654d1d276c0e5b587357456e0bb6758a114b54f82e9e4b"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a487c3d13600d2f821ad6e46f20b7ae0f2c96b53df7a33d1077832ca1c7cb7df"
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
      bin.install "git-tui", "gnostr-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-tui", "gnostr-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-tui", "gnostr-tui"
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
