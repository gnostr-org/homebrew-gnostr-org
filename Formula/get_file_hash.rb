class GetFileHash < Formula
  desc "A utility crate providing a procedural macro to compute and embed file hashes at compile time."
  homepage "https://github.com/gnostr-org/get_file_hash"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.3.3/get_file_hash-aarch64-apple-darwin.tar.xz"
      sha256 "22951d34969d899a756752498b52f180a68d27146bea8b4c82a8a55ef797adfb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.3.3/get_file_hash-x86_64-apple-darwin.tar.xz"
      sha256 "000cc7c4b47f1a8e3cbc3d8420c519ab4b85f71f1a28226e89ab8a6a77aa9115"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.3.3/get_file_hash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ac60a8cd11cd2378e8642d7dfbcd33e7e376dd7d17787776c112c95b2eaf0e21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.3.3/get_file_hash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9edfdf2ec2fccf05b6ef5bbafc46fef70f055081f440b5dd33c8c80bf8eb34fd"
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
