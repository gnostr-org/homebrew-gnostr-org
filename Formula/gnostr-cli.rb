class GnostrCli < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.30"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.30/gnostr-cli-x86_64-apple-darwin.tar.gz"
    sha256 "ca3b3e0aae08380f2c1acdfce800b2cfce54b77a5926bb929b254d402b967fba"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.30/gnostr-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eea2a8820689410e32b22cf527d1518551078bedb250be4d39efeecef219600a"
    end
  end
  license "Apache-2.0"
  
  depends_on "openssl@3"
  depends_on "openssl@3"
  depends_on "openssl@3"
  depends_on "openssl@3"

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
      bin.install "gnostr-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-cli"
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
