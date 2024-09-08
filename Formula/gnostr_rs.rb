class GnostrRs < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr_rs"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr_rs/releases/download/v0.0.3/gnostr_rs-aarch64-apple-darwin.tar.xz"
      sha256 "9d55e348e5cce1d0b3cd2ce9a6ba64bd62f0ecca182c1e80b7a41c47290adc78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_rs/releases/download/v0.0.3/gnostr_rs-x86_64-apple-darwin.tar.xz"
      sha256 "1f1b1a62bc214d77293374e73650dc3fb7ccfbd1a783a2193f313c69f57fd26d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_rs/releases/download/v0.0.3/gnostr_rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a3cdb592090c18cf91fc4584a2fda058f4b8d7925d11f63b3502b67a4da42a25"
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
      bin.install "gnostr"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr"
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
