class GnostrXq < Formula
  desc "gnostr-xq:A reimplementation of jq."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.43"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-xq-aarch64-apple-darwin.tar.gz"
      sha256 "4fc335f40824e484f03caea5e78f75bfe66f172bcc143618c6123d2bfc86bf7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-xq-x86_64-apple-darwin.tar.gz"
      sha256 "719e5ccf6d89002241f386c4f3cca4171750f239949c988f32ddf4ce2d4a13d7"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/gnostr-xq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cdc0490a518ea4f66b4c6071fbb1e7905218e2241c771266b170e85ef02e158b"
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
      bin.install "gnostr-xq"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-xq"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-xq"
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
