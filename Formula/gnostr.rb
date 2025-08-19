class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.114"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.114/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "a6027a5f0135085581d52e16f3a1fd5e0800610bde8e2326b51abf9dc9566fe3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.114/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "359216a79ea96dec20a9ce1797e23cae552ff432fe6cf16263270b7b5755d65d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.114/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a759b481b35c9b3f19da7cb63c372c7409a6a8b8385c4f8ac9622602ffee5e0d"
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
