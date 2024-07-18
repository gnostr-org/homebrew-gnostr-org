class GnostrTui < Formula
  desc "blazing fast terminal-ui for git"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.49"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-tui-aarch64-apple-darwin.tar.gz"
      sha256 "85c3ab39d70e6e60542c3bee686fb5c697805fe9eb58a68cca4debfacf374436"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-tui-x86_64-apple-darwin.tar.gz"
      sha256 "1b26d11edad8ac1cfe1220b4e3dc17f7c90024d0c46d819fd2e1e2c33757ffbf"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6d20a43cfdc88a207b8776dbd97ff6699e6ae0f47d2d838a309e3b89d552c13"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
