class GnostrXq < Formula
  desc "gnostr-xq:A reimplementation of jq."
  homepage "https://github.com/gnostr-org/gnostr-xq"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.3/gnostr-xq-aarch64-apple-darwin.tar.xz"
      sha256 "691ab81d0c8f336a52e3436321cb8f22a5a8933bc3a4371504bb63bf7af8ddbf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.3/gnostr-xq-x86_64-apple-darwin.tar.xz"
      sha256 "2e46cd7b12a6d587a373e99672796ee1510128898300048cc7d6c4b2f3e8deb9"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.3/gnostr-xq-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c1c0a5d5b09cb610353ffd7b86725751c2be5afa034cf90172dfc50f08303b15"
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
    bin.install "gnostr-xq" if OS.mac? && Hardware::CPU.arm?
    bin.install "gnostr-xq" if OS.mac? && Hardware::CPU.intel?
    bin.install "gnostr-xq" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
