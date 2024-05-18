class Nips < Formula
  desc "The nips application"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.42"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/nips-aarch64-apple-darwin.tar.gz"
      sha256 "098ee97f4dd466a8207db7933e19d4e41c9a2f5efe9dd7695941d668f4d40236"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/nips-x86_64-apple-darwin.tar.gz"
      sha256 "8f09bdcd4248f9da32fff890a865e1fae9879c86333a628110c83054f88d47d1"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/nips-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8201ce2cee5bdc9afa8ba221a7ffb78852ebd7b8959d496c84a09c2d6a65bdaa"
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
