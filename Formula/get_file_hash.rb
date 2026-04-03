class GetFileHash < Formula
  desc "A utility crate providing a procedural macro to compute and embed file hashes at compile time."
  homepage "https://github.com/gnostr-org/get_file_hash"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.3.2/get_file_hash-aarch64-apple-darwin.tar.xz"
      sha256 "062fc72911455f124182c0c6fdd12abca04e00f87ac5f12e27689142590cbb27"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.3.2/get_file_hash-x86_64-apple-darwin.tar.xz"
      sha256 "833fd64013de75713b36e7902723b91571e34b66d2c86f82e6b9fd4b462ba895"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.3.2/get_file_hash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "05509fb81e939f2bd4865faf4b6614de3188f0ad5dbe2e7df6f75c826e11a479"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.3.2/get_file_hash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cfed4267d79c5bde2485cfc2b3fe0c612ab20e5bb4bb315c02ae945e136cfdea"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "get_file_hash", "readme" if OS.mac? && Hardware::CPU.arm?
    bin.install "get_file_hash", "readme" if OS.mac? && Hardware::CPU.intel?
    bin.install "get_file_hash", "readme" if OS.linux? && Hardware::CPU.arm?
    bin.install "get_file_hash", "readme" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
