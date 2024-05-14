class GnostrCli < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.33"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.33/gnostr-cli-x86_64-apple-darwin.tar.gz"
    sha256 "c5bd0b1d5b1cbe27789406c7b97184c0035ce3268c5d1889ad0c153438822c22"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.33/gnostr-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9085070c712f5c95331282efb91a359c9bcf8a2180254aa563779ffe1d06b051"
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
