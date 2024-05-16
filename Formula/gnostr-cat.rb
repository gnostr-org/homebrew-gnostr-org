class GnostrCat < Formula
  desc "Command-line client for web sockets, like netcat/curl/socat for ws://."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.40"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.40/gnostr-cat-x86_64-apple-darwin.tar.gz"
    sha256 "a54c37b0daccc1f8c1b39543fea0e4a07f86840988d545153453a86c6866ead8"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.40/gnostr-cat-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bf16903cea2305e7a484817e0089c64ecc312487ebed7e1a81a15ea9ab66df30"
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
      bin.install "gnostr-cat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-cat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-cat"
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
