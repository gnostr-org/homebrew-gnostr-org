class GnostrClean < Formula
  desc "Quickly clean up your development directories on disk"
  homepage "https://github.com/gnostr-org/gnostr-clean"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-clean/releases/download/v0.0.2/gnostr-clean-aarch64-apple-darwin.tar.xz"
      sha256 "fe7d014b2820c007bb8c2c4f6a5c119261cf528df0a46c1112d2fcebe5aaf7b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-clean/releases/download/v0.0.2/gnostr-clean-x86_64-apple-darwin.tar.xz"
      sha256 "1aa15f807d8a0879688b6d58c14fa25e49988a5d4ea2c6a812394dbf0c488fa4"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-clean/releases/download/v0.0.2/gnostr-clean-x86_64-unknown-linux-gnu.tar.xz"
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
    bin.install "gnostr-clean" if OS.mac? && Hardware::CPU.arm?
    bin.install "gnostr-clean" if OS.mac? && Hardware::CPU.intel?
    bin.install "gnostr-clean" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
