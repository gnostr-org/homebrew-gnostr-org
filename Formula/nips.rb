class Nips < Formula
  desc "nips: a nostr-protocol/nips server"
  homepage "https://github.com/gnostr-org/gnostr-nips"
  version "0.0.38"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.38/nips-aarch64-apple-darwin.tar.xz"
      sha256 "ff0cfb01538960179e310274a3583ee9006afe561bd1d233dfe9a4c3d792c027"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.38/nips-x86_64-apple-darwin.tar.xz"
      sha256 "ed41fffdb72a6807dd8caff43ed6b815d0d2245b935b7859e7f2acd6c58e9eca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.38/nips-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8bb57729d9408f4bab31fa158729db43aa4e2c1a975912c9d045b13481a7b763"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.38/nips-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8b452e0614bcad9fce516e31e4ae955d07b0ca39f4ca4f7f44cf52db6d1073e6"
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
