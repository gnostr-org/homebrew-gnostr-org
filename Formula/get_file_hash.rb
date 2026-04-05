class GetFileHash < Formula
  desc "A utility crate providing a procedural macro to compute and embed file hashes at compile time."
  homepage "https://github.com/gnostr-org/get_file_hash"
  version "0.4.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.6/get_file_hash-aarch64-apple-darwin.tar.xz"
      sha256 "9498e0cb6c5f148f5e5985c54ce9d72939b4630557059b3107cbd900b09013a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.6/get_file_hash-x86_64-apple-darwin.tar.xz"
      sha256 "2bc8173952874c94e4bc915159d25ed0c30211a0733ab7badf3340bd5d50d926"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.4.6/get_file_hash-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "fc95d853d39c7365dfba85873f1bc8372e5b221289eb1b59fe1603197b3e4fa8"
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
