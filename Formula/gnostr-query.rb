class GnostrQuery < Formula
  desc "gnostr-query: retrieve nostr events."
  homepage "https://github.com/gnostr-org/gnostr-query"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.5/gnostr-query-aarch64-apple-darwin.tar.xz"
      sha256 "944bbaef3e6205e2b720db35fd1a4d5fd2e34119924138395bd023c4ef1ea8aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.5/gnostr-query-x86_64-apple-darwin.tar.xz"
      sha256 "44c0d70b470daeaf059c5a7fbe5c47c6234dbb4413ce2975468a248671409e03"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.5/gnostr-query-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "5ceab5109479dbf73bcab0b82207eeef82dada39ac60e6ce197733c8cecd7b85"
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
    bin.install "extract_elements", "gnostr-query" if OS.mac? && Hardware::CPU.arm?
    bin.install "extract_elements", "gnostr-query" if OS.mac? && Hardware::CPU.intel?
    bin.install "extract_elements", "gnostr-query" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
