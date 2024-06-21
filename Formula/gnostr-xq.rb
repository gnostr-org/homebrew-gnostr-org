class GnostrXq < Formula
  desc "gnostr-xq:A reimplementation of jq."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.44"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-xq-aarch64-apple-darwin.tar.gz"
      sha256 "e6fafcaebb2f96e8f928cbe3456ee554ec3bcbc4e491d9e64c8c1a4a062831de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-xq-x86_64-apple-darwin.tar.gz"
      sha256 "9b0f538de4509816770d6169ae76f3c7bb029a1a0c0925c906f01faefa3d3681"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-xq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55444e7b77e7ecd755c074dcb2b9784487a4b4fffa0a4f63feec1816818d1cf7"
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
