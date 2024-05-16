class Nips < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.38"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.38/nips-x86_64-apple-darwin.tar.gz"
    sha256 "b7b95fa5ff5babbfac0c534b715a6015ab1fa09181d4896d5e5b8e5ae158c36b"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.38/nips-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c8412d807f4c7325ea189552e86e870ef2501c24e001f1037c3c6e9a3231e8ef"
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
