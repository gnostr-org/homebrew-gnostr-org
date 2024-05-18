class GnostrGui < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.43"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-gui-aarch64-apple-darwin.tar.gz"
      sha256 "f33268177834bd22a3302920adda427be2a3781c66b61c0493b0dbaa078de9eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-gui-x86_64-apple-darwin.tar.gz"
      sha256 "46929b0d1bda5147de07d5e467cd5cc8bebf9860b95d8634b69d24c1449da01d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-gui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "845a23ee9bbee9e73fb77dc571e3a76811bba3c318676194a00cdc0dbdfbd65b"
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
      bin.install "gnostr-gui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-gui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-gui"
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
