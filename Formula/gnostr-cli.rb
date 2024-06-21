class GnostrCli < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.45"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-cli-aarch64-apple-darwin.tar.gz"
      sha256 "8cd87d29c0db3f423acfe29135ddd25aed4888400b7bc67a4607e75b37c4c345"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-cli-x86_64-apple-darwin.tar.gz"
      sha256 "ec4a46e1d4d4782f14d421444cc2df38ef4613149805334a5fcd98931925b592"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c685a36a291ace3fb051942e6c8d82549a33adab4b5c1795c568e9f36dd3f723"
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
      bin.install "git-cli", "gnostr-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-cli", "gnostr-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-cli", "gnostr-cli"
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
