class GnostrTui < Formula
  desc "blazing fast terminal-ui for git"
  version "0.0.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.8/gnostr-tui-aarch64-apple-darwin.tar.xz"
      sha256 "1a9953c9ed210d6ce633056fab3e8c8dcd6fbd4714ae90de7bff0a3c3cf425f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.8/gnostr-tui-x86_64-apple-darwin.tar.xz"
      sha256 "40ada06edda4e9ce21130c25580f5b10cf3f39e3845b9fee63e499e2802b1952"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.8/gnostr-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8f80f1773a67174e8402d708692122aad7f4fc5c4b9a27be335bf422921a5e78"
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
