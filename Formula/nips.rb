class Nips < Formula
  desc "The nips application"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.44"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/nips-aarch64-apple-darwin.tar.gz"
      sha256 "d997f7706744a3bd3c557829f8af01d11ac697a3457eac0edacab7b1e496579a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/nips-x86_64-apple-darwin.tar.gz"
      sha256 "35e91b7764c42f39624cee1ae24e7438c28ad3ccd3b59dd605894797e84c6aa8"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/nips-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "47c3898e9a12772a49f10751411ab996c25348c56b000743f0a1e0f92bdae8a7"
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
      bin.install "nips"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nips"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nips"
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
