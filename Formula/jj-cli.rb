class JjCli < Formula
  desc "gnostr: a git+nostr workflow utility."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.49"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/jj-cli-aarch64-apple-darwin.tar.gz"
      sha256 "e90849b816a038d20a0620584c1e339c18d5d75a2ee46e697e90c38bd7097ccb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/jj-cli-x86_64-apple-darwin.tar.gz"
      sha256 "08a6f8bc8e2b10623d6d043b5b44cae6d83af02a86c45f1b959bb10ca7418dd1"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.49/jj-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e29f0675a5d1f08c1b59664cdf2e40ba17a5d49908262fe569e79fb404958df1"
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
