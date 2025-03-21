class GnostrQuery < Formula
  desc "The gnostr-query application"
  homepage "https://github.com/gnostr-org/gnostr-query"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.1/gnostr-query-aarch64-apple-darwin.tar.xz"
      sha256 "f92987b87c786786401006a3a4f2221785ff074fad87bebacffce4e7b1b37376"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.1/gnostr-query-x86_64-apple-darwin.tar.xz"
      sha256 "1090a3c13ed6642c2864a0a9b00a3d0882b1322a95b512d01739ab124896de49"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.1/gnostr-query-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "9663f33c582b5e0ba654b1be3a55b06b021f0cde6d281167d11045eda62c68ab"
  end

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
    bin.install "gnostr-query" if OS.mac? && Hardware::CPU.arm?
    bin.install "gnostr-query" if OS.mac? && Hardware::CPU.intel?
    bin.install "gnostr-query" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
