class GetFileHash < Formula
  desc "A utility crate providing a procedural macro to compute and embed file hashes at compile time."
  homepage "https://github.com/gnostr-org/get_file_hash"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.6/get_file_hash-aarch64-apple-darwin.tar.xz"
      sha256 "2b05302f9cce71b90c36c78bb1bc850f4cef809f6a6fc010e8effcddb3853d5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.6/get_file_hash-x86_64-apple-darwin.tar.xz"
      sha256 "07f4df1a55cec7e8c35dce8b0850d62c5f5ab4ea7ddc43b62f3b63fadad33190"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.6/get_file_hash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3ffb7d71a191f7301752e4c1b0576944cd821ea55d71ec46e97b851b099001d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/get_file_hash/releases/download/v0.2.6/get_file_hash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47ce0b2b7384dcf172481a20f39c6fecd722eba8e3b19a68184ef1132de63d62"
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
