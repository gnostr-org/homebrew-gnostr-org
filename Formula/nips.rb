class Nips < Formula
  desc "nips: a nostr-protocol/nips server"
  homepage "https://github.com/gnostr-org/gnostr-nips"
  version "0.0.39"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.39/nips-aarch64-apple-darwin.tar.xz"
      sha256 "4dc7c871ab55b005adfbc717c27e2ac74940eb1f8a5fded9df8085277b2572a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.39/nips-x86_64-apple-darwin.tar.xz"
      sha256 "f69b8ea842f62dc5c00248ba00c8865c8e7d6e0bac3ca7e80f17efaed308c2c7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.39/nips-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8310cd5850fffceaff8c16dd971430c56e1fa6158ca4ae4c007f24a9a04e9721"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.39/nips-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "05aeca73a6c528393d29cd5567d5938afdd1407ef8faed520c0c6f33202d2bbd"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
    bin.install "nips" if OS.mac? && Hardware::CPU.arm?
    bin.install "nips" if OS.mac? && Hardware::CPU.intel?
    bin.install "nips" if OS.linux? && Hardware::CPU.arm?
    bin.install "nips" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
