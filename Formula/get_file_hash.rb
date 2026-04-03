class GetFileHash < Formula
  desc "A utility crate providing a procedural macro to compute and embed file hashes at compile time."
  homepage "https://github.com/gnostr-org/get_file_hash"
  version "0.2.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.9/get_file_hash-aarch64-apple-darwin.tar.xz"
      sha256 "6fb5f6df359da74e140f77d95b8f96a8f6c49f73a5352acbbaf352054ae32fb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.9/get_file_hash-x86_64-apple-darwin.tar.xz"
      sha256 "c91c00ef7b2abbb5f07ca107fa893ea861d68844a448b6cf80ea3f0fc781d4b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.9/get_file_hash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "86ad2994bffb4d3ddd526bace44a72940917de7ff5ececa30de9a3976a2610f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.9/get_file_hash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6ae7ca332f2f14f8bf032a3000d6d857efffb2afc8d9d5b69311f5eeefc6544"
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
