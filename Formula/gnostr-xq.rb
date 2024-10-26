class GnostrXq < Formula
  desc "gnostr-xq:A reimplementation of jq."
  homepage "https://github.com/gnostr-org/gnostr-xq"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.5/gnostr-xq-aarch64-apple-darwin.tar.xz"
      sha256 "f447095f083aa2b21ed0ef3158d936c94bafc1f004373939bb7c266774b297d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.5/gnostr-xq-x86_64-apple-darwin.tar.xz"
      sha256 "b0d46710e34f5958449fe5ff3e6da381662a5a124a7756d7dbcd50b4c9abaeec"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.5/gnostr-xq-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "3e459675f7c3ba931602deea464f01ea080489c5dd661f48dd4c528c79b48f6e"
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
