class GetFileHash < Formula
  desc "A utility crate providing a procedural macro to compute and embed file hashes at compile time."
  homepage "https://github.com/gnostr-org/get_file_hash"
  version "0.4.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.7/get_file_hash-aarch64-apple-darwin.tar.xz"
      sha256 "c28b817b946fbc8cf49891031a22c58b753ee0ee6cc30aceba8e89753dd4b2c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.7/get_file_hash-x86_64-apple-darwin.tar.xz"
      sha256 "78f6d27b3325d39361465a7178f4a4cf47fbdaaceafc34fc2f08ab64d08e42c7"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.7/get_file_hash-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "df85d44252c0c62f225d1f3b2f2b947ab47469f4a548fa42dfbe5e065a13cbc7"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "get_file_hash", "n34", "n34-relay", "readme" if OS.mac? && Hardware::CPU.arm?
    bin.install "get_file_hash", "n34", "n34-relay", "readme" if OS.mac? && Hardware::CPU.intel?
    bin.install "get_file_hash", "n34", "n34-relay", "readme" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
