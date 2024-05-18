class JjCli < Formula
  desc "gnostr: a git+nostr workflow utility."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.43"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/jj-cli-aarch64-apple-darwin.tar.gz"
      sha256 "618a666561b83266d5269da928661a83612b6913ff7deb682d1f595f6d6bdc41"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/jj-cli-x86_64-apple-darwin.tar.gz"
      sha256 "0658c817481bf810d4f9b0f6ee04f8990ca88dbc7787a9225ae8a7fd1b2a31d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.43/jj-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "898ad45c27a2a9a3140a5b8a051f41d5931877f0fea77a47d99283723d77f27d"
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
      bin.install "fake-diff-editor", "fake-editor", "git-gnostr", "git-gnostr-gui", "git-gnostr-jj", "gnostr", "gnostr-gui", "jj"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fake-diff-editor", "fake-editor", "git-gnostr", "git-gnostr-gui", "git-gnostr-jj", "gnostr", "gnostr-gui", "jj"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fake-diff-editor", "fake-editor", "git-gnostr", "git-gnostr-gui", "git-gnostr-jj", "gnostr", "gnostr-gui", "jj"
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
