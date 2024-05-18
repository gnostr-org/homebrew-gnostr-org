class GnostrCat < Formula
  desc "Command-line client for web sockets, like netcat/curl/socat for ws://."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.43"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-cat-aarch64-apple-darwin.tar.gz"
      sha256 "7ebf6aa5ad343d40a88154d59897b412288af47b5448848b2b9847249095eed8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-cat-x86_64-apple-darwin.tar.gz"
      sha256 "9e8106383df9145e54f1a0edb8ce5b54880de70e8134b01217503f7854a912fe"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-cat-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b69e27d204bd99ae8c36893e72b33195ab772ed008063447da8e695d0e4f7360"
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
