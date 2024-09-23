class GnostrQr < Formula
  desc "gnostr_qr: part of the git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr_qr"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.6/gnostr_qr-aarch64-apple-darwin.tar.xz"
      sha256 "15320d6baf182dfa02c19b58f2be74644161e75869e95f8dfacabc03e4b33ed3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.6/gnostr_qr-x86_64-apple-darwin.tar.xz"
      sha256 "d2f3f98b4391a15e89c52a5265fa4fc7bb5de1f8e96a33ec32be712364e7cb38"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.6/gnostr_qr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2eb440803cbd0a07fe16a8414924a2b484420402cd6befbb3ddef25116d0b0e9"
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
