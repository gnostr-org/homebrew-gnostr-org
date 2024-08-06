class GnostrQr < Formula
  desc "gnostr_rs: part of the git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr_qr"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.2/gnostr_qr-aarch64-apple-darwin.tar.xz"
      sha256 "1d7c287add8f52be32bf057288078dc04dc4f806195504890b1992fc6b8c259c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.2/gnostr_qr-x86_64-apple-darwin.tar.xz"
      sha256 "c3e174f37b46a83080cc30176ba10ba30755712007f689cb37a53230c3793122"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.2/gnostr_qr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "055397b9adb7e2a44ba790cd89377b08c83d29b93ce3965f77092ca9b9fecafa"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "gnostr-qr"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-qr"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-qr"
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
