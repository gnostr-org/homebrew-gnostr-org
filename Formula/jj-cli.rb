class JjCli < Formula
  desc "gnostr: a git+nostr workflow utility."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.31"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.31/jj-cli-x86_64-apple-darwin.tar.gz"
    sha256 "d248cdd7402de0b066297c064a1b34be7f22d769593ec23bc6ce929f121bd971"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.31/jj-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "df11bbb324f65e495394be85c5a8c5de3eddf3e52f93a73d82798978d626a4d6"
    end
  end
  license "Apache-2.0"
  
  depends_on "openssl@3"
  depends_on "openssl@3"
  depends_on "openssl@3"
  depends_on "openssl@3"

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
      bin.install "fake-diff-editor", "fake-editor", "gnostr", "gnostr-jj", "gnostr-jj-gui", "jj"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fake-diff-editor", "fake-editor", "gnostr", "gnostr-jj", "gnostr-jj-gui", "jj"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fake-diff-editor", "fake-editor", "gnostr", "gnostr-jj", "gnostr-jj-gui", "jj"
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
