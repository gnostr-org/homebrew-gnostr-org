class GnostrQr < Formula
  desc "gnostr_rs: part of the git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr_qr"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.3/gnostr_qr-aarch64-apple-darwin.tar.xz"
      sha256 "e363de0e53dd4e517647cb32d6b9394e44180ec5c6b4450a943f7d12ba036e08"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.3/gnostr_qr-x86_64-apple-darwin.tar.xz"
      sha256 "aa78d77f815390fcbbc7a930fdcbef5ab900d7bc30197fd909914bc0cb45b2fd"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_qr/releases/download/v0.0.3/gnostr_qr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "40726dd07c747c18895fc596bc67c20aba400cd70ca62962f23eca72c46f48b3"
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
