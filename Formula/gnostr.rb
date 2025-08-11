class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.113"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.113/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "00e76ce9a684636592169f48c23499f51132d201e773c30b27657039657caa5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.113/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "280ddaef5e57a777d58007ef174ea8483449065f0f543fca3e023cea197c1566"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.113/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "d6bd8422b2f9f7d9ad4065291a13c4e18c9710f54bc86b088c71736461cb2380"
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
"gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-weeble", "gnostr-wobble", "server-toml"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash",
"gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-weeble", "gnostr-wobble", "server-toml"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash",
"gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-weeble", "gnostr-wobble", "server-toml"
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
