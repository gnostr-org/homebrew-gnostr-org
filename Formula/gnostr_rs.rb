class GnostrRs < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr_rs"
  version "0.0.7"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr_rs/releases/download/v0.0.7/gnostr_rs-x86_64-apple-darwin.tar.xz"
    sha256 "58de32acc812af2f8e61268d6992c91120ac95639020f09a2a2cf61be189aaaf"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_rs/releases/download/v0.0.7/gnostr_rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21b1c6d0cd291bde7d98b528a549711094685ac320b950ae4b92bd788c6e7db2"
    end
  end
  license "MIT"
  
  depends_on "openssl@3"
  depends_on "openssl@3"
  depends_on "openssl@3"
  depends_on "openssl@3"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "gnostr_dashboard", "gnostr_rs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr_dashboard", "gnostr_rs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr_dashboard", "gnostr_rs"
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
