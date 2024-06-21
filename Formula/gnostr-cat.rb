class GnostrCat < Formula
  desc "Command-line client for web sockets, like netcat/curl/socat for ws://."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.44"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-cat-aarch64-apple-darwin.tar.gz"
      sha256 "9aedc9ca15ee1870bd0b01cb44b6bdf7e4e80de595b230c615567398d8841bf1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-cat-x86_64-apple-darwin.tar.gz"
      sha256 "72e0498f646c81e49bf51db02f674407243ae74f46a483f12cdf2ce7b1c476df"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-cat-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0b294906aa212720aceea803b621fcef816d9e4b7cd8a97280926fdb5c66f5b5"
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
