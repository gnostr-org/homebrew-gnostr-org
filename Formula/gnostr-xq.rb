class GnostrXq < Formula
  desc "gnostr-xq:A reimplementation of jq."
  homepage "https://github.com/gnostr-org/gnostr-xq"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.4/gnostr-xq-aarch64-apple-darwin.tar.xz"
      sha256 "5927f64694d5dabc1b9506599ad496af1eb2403b86d62214b9d1a62960c0483c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.4/gnostr-xq-x86_64-apple-darwin.tar.xz"
      sha256 "9f150c5ca7c2247904d25d370a7ac66a3b7fcaf75e4ea8b6e76bbe70ef776bc2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-xq/releases/download/v0.0.4/gnostr-xq-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ca57244d0ac88985469e10d07d5d9adeab75c17fe80efab2537955b60cd6ae52"
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
