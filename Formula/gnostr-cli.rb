class GnostrCli < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.49"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-cli-aarch64-apple-darwin.tar.gz"
      sha256 "83cac3ee9891d04c8481054c580f13b337178de0ff603ad66ac701947bbd2eee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-cli-x86_64-apple-darwin.tar.gz"
      sha256 "54776ea86a8c9968fe9b004acda4bc225e095a4f937b54969067909c8d106fae"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/gnostr-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e2ea9c61ef0b9133d73643fa51817bde3a0fed2fd8f85757c947b111625acb0c"
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
