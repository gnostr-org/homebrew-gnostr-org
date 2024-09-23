class GnostrQr < Formula
  desc "gnostr_qr: part of the git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr_qr"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.5/gnostr_qr-aarch64-apple-darwin.tar.xz"
      sha256 "6211e352f6ae4f2ae0dd3826215c7ea34e9c0a7e13c6b05d721cbd29e85e21f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.5/gnostr_qr-x86_64-apple-darwin.tar.xz"
      sha256 "b75f1021df9533851f485a99232f78fdaa47fa18501d7db5040ab4f669a9c8dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.5/gnostr_qr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c974f547e9ef9fcbd6e5268654b15708c95f1757d8baa5771bc20d420ef4868e"
    end
  end
  license "MIT"

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
