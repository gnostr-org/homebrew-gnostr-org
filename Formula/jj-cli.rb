class JjCli < Formula
  desc "gnostr: a git+nostr workflow utility."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.40"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.40/jj-cli-x86_64-apple-darwin.tar.gz"
    sha256 "877497dffc46e634dbff3461a5cdc1688e4dd474c6660674273aceae85070806"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.40/jj-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "17099f05e2e97bea2c88e7c6c1a5ebfcfe2eb2c6cc74134f56e873103af6a2eb"
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
