class GnostrTui < Formula
  desc "blazing fast terminal-ui for git"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.7/gnostr-tui-aarch64-apple-darwin.tar.xz"
      sha256 "f21ecde11a324217e05fedede680ab65ecc1e1678887bd8bfa89b348c0df479e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.7/gnostr-tui-x86_64-apple-darwin.tar.xz"
      sha256 "882c82b7bd5b0a57ae842639c0460fc18c6a8867fffcff08dedcb86bdef8a6b9"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.7/gnostr-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c8da8a44d60d0d918070f65ef7401bef517f2a433b9f8660a8c6952fe54126fa"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "gnostr-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-tui"
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
