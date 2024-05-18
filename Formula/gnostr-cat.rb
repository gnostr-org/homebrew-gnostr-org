class GnostrCat < Formula
  desc "Command-line client for web sockets, like netcat/curl/socat for ws://."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.42"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-cat-aarch64-apple-darwin.tar.gz"
      sha256 "5e4de8989a888dfcd0c75ec8d30cce95cd02077f13dded0301e021529063b6af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-cat-x86_64-apple-darwin.tar.gz"
      sha256 "860d80471fcf187256ed00385dc9fc47d9e6b6216b1affbdc2e65c5ee833033f"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-cat-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "63da36299b4ac533bac201ab8ea53f905bec2df8c33fb7f64613d20a091ade6b"
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
