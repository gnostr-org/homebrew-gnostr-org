class GnostrLookup < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.45"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-lookup-aarch64-apple-darwin.tar.gz"
      sha256 "d033f1b3f83799334bde41d26e1326554812f57b024d6815a0f106be6f2d2a80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-lookup-x86_64-apple-darwin.tar.gz"
      sha256 "868138d736bb192101e6efa9a56143ab48e1ad575ade94343593dd6d2b228f44"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-lookup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7b84ed4f10dfe5dc4ffbf592421d22fc41684f20520756c198e8de416c0e5df1"
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
