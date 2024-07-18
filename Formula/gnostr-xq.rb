class GnostrXq < Formula
  desc "gnostr-xq:A reimplementation of jq."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.49"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-xq-aarch64-apple-darwin.tar.gz"
      sha256 "59362bb489aa4888f833568cb09fc766b54100d78918ca3ecfac3eba6958dfc6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-xq-x86_64-apple-darwin.tar.gz"
      sha256 "e0c40cdfe67f729e80c5fa7d5511ff8eb469625398d12800826d6f13ef60eb40"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-xq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ced67feac74c5939b04dfdcc0b236b59f7dc3393316bfebadfdc8a978d5b11b0"
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
