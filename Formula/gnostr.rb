class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.119"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.119/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "35ebf27ca234592e4de98d54fb62861da0ddb166a8286a380a656a043889f969"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.119/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "e98799ffe998a819c88a670d07c2a66d5d2f3ce93d31a14422c77f4c26707c2f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.119/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "03fcf5e4f3dd9160dcb13163af4a29d70e04f52af47c53c908828330c94527c2"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

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
      bin.install "generate-server-config", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash",
"gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash",
"gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash",
"gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
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
