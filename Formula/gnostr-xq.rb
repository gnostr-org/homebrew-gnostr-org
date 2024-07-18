class GnostrXq < Formula
  desc "gnostr-xq:A reimplementation of jq."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.50"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/gnostr-xq-aarch64-apple-darwin.tar.gz"
      sha256 "bda2aa7e5b93b6799cab25b2227e4b1311198573346bf57436bca5f52855e641"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/gnostr-xq-x86_64-apple-darwin.tar.gz"
      sha256 "dc134e3199e9cebd872477328e1194b0edb58b5aa6601f2a549b31eca40d4ec6"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/gnostr-xq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6087bf3d00507884ed4e9f924908ace13ff7fdae03d8eb4ecd94fe2c7fa830af"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
