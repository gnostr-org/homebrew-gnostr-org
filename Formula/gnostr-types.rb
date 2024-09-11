class GnostrTypes < Formula
  desc "Types for nostr protocol handling"
  homepage "https://github.com/gnostr-org/gnostr-types"
  version "0.7.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-types/releases/download/v0.7.5/gnostr-types-aarch64-apple-darwin.tar.xz"
      sha256 "ab88f9131713a99671aaf87bc15976b08f3b404c58be33de35e10ac99891f3e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-types/releases/download/v0.7.5/gnostr-types-x86_64-apple-darwin.tar.xz"
      sha256 "fdf4405ec7f5d39a7aaee6c4b9c1110622665d8135e5559e4298ace68e4488ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-types/releases/download/v0.7.5/gnostr-types-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "403609619204e1b971095c35796876dbf5bcffaa93a0fd1d4c65e35df5b12ac4"
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
      bin.install "gnostr-types"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-types"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-types"
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
