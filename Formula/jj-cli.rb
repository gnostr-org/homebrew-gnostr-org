class JjCli < Formula
  desc "gnostr: a git+nostr workflow utility."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.50"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/jj-cli-aarch64-apple-darwin.tar.gz"
      sha256 "974f58bedcccfe7e0e81f864127c9a4bae67c8d7d1ff08aa9f7ffad40b914067"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/jj-cli-x86_64-apple-darwin.tar.gz"
      sha256 "d250e552fe0eec0dc4062fc00678e94b786683530b8934e938444b047f75a4a9"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/jj-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2f9667896c50979373b7af1f8e66967b07f2b2f6371ae0b5acf58bcb0ed2b1b1"
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
      bin.install "fake-diff-editor", "fake-editor", "git-gnostr-jj", "gnostr", "jj"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fake-diff-editor", "fake-editor", "git-gnostr-jj", "gnostr", "jj"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fake-diff-editor", "fake-editor", "git-gnostr-jj", "gnostr", "jj"
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
