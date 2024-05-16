class Gnostrd < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.36"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.36/gnostrd-x86_64-apple-darwin.tar.gz"
    sha256 "ff9d9ee8ccbc2c281ab110140384fa087b4cf7f67b4104f9ebc82b0b1c73feb5"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.36/gnostrd-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3e50ada02c110b0fdc46f2817faeff8ecd9d84aea4eec5c0095d0fa40940f7f0"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "gnostr--d", "gnostr-chat", "gnostr-d", "gnostrd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr--d", "gnostr-chat", "gnostr-d", "gnostrd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr--d", "gnostr-chat", "gnostr-d", "gnostrd"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
