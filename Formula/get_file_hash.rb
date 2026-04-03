class GetFileHash < Formula
  desc "A utility crate providing a procedural macro to compute and embed file hashes at compile time."
  homepage "https://github.com/gnostr-org/get_file_hash"
  version "0.2.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.8/get_file_hash-aarch64-apple-darwin.tar.xz"
      sha256 "2acb68221078ef8bf002b313479b3c04a9c0ac0fccbbf2304288da2b75edc8be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.8/get_file_hash-x86_64-apple-darwin.tar.xz"
      sha256 "177e3534ea929a062d7b8a23776b09c02ac128620a1849ed7dc6e072f9e0b52b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.8/get_file_hash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e5e193d2d661169462e2d7d46fca858d152497815306f1f671676da29d7e215c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.8/get_file_hash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c6d6d30f69129fd2b5cc5e469a7cd919812e78bb15903a93e754211c2557e0f3"
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
