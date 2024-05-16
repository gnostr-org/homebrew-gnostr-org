class GnostrLookup < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.40"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.40/gnostr-lookup-x86_64-apple-darwin.tar.gz"
    sha256 "6c1372e4ccace5904742c0e885203e337fa23235ba9c8e1a523c1a002627c769"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.40/gnostr-lookup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0206976105115a6477ff9a8ff5a141cca20ee55112df9ac284b197fad7205ec4"
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
