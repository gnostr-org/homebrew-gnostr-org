class GnostrLookup < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.44"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-lookup-aarch64-apple-darwin.tar.gz"
      sha256 "ca004f22cbf678e6f1d2afafd06cfe832800ee7e585bf501e55afd938ef16802"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-lookup-x86_64-apple-darwin.tar.gz"
      sha256 "815dc60aa1f9f8130bb4a2c9002101d42bf05f252008fad6a2eab609e260938e"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-lookup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e73ffe5c74dc225ad91a5a9bcc8ebe4d66587b81b43962ec099d5c17904daa4d"
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
      bin.install "gnostr-lookup"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-lookup"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-lookup"
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
