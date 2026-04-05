class GetFileHash < Formula
  desc "A utility crate providing a procedural macro to compute and embed file hashes at compile time."
  homepage "https://github.com/gnostr-org/get_file_hash"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.5/get_file_hash-aarch64-apple-darwin.tar.xz"
      sha256 "7e55c79cd5552f13ba3fd051926d574f3cb17d4f55a8283805c1693ce26c72d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.5/get_file_hash-x86_64-apple-darwin.tar.xz"
      sha256 "c2d9d2ce9e32ec2b91cef02ad9eb28f46a5b7c61efa58d2050cd04b1b3e0d31d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.5/get_file_hash-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "14faff1d7af633977617b0cddeb84b293cf0ec9d467a4bc8d822227353c09005"
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
