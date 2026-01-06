class Gtr < Formula
  desc "rust implementation of gittorrent"
  homepage "https://github.com/RandyMcMillan/gtr"
  version "0.0.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.9/gtr-aarch64-apple-darwin.tar.xz"
      sha256 "c5025de387096e5807781475458866d39f0150dd29a374770f3b19bdb03019a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.9/gtr-x86_64-apple-darwin.tar.xz"
      sha256 "6bdb1ed93b8a22cc8d21ee8f6b6d94795466b2bd1b2fff7ec90af731ea45d806"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.9/gtr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "df322eaacb59dc38b7d935c2bf1c4950164622d0771f60e9af6556ae5aa5d555"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.9/gtr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2862b0aa5ecb3c9f7200060a3d3e0282a7abbae42500a888bd7ba79d186d2c8a"
    end
  end

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
    bin.install "gtr" if OS.mac? && Hardware::CPU.arm?
    bin.install "gtr" if OS.mac? && Hardware::CPU.intel?
    bin.install "gtr" if OS.linux? && Hardware::CPU.arm?
    bin.install "gtr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
