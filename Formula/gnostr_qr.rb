class GnostrQr < Formula
  desc "gnostr_rs: part of the git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr_qr.git"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.1/gnostr_qr-aarch64-apple-darwin.tar.xz"
      sha256 "b105647a6ed24c900146d3d4ee9703ee4e794869c6436bb8c5f53c9b066e180f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.1/gnostr_qr-x86_64-apple-darwin.tar.xz"
      sha256 "39331eb94f97cf41a2b3695ea629d0843b521be2cdb6faf43154f42d1a9d2c3f"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.1/gnostr_qr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff80c13548cec8f81af4547ab569d67e7a86154e05e1c7a9fd7558eae7c79424"
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
