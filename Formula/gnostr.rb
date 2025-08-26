class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.115"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.115/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "1d19ab4ecfd3cdcbecc0eca53adf2bbdb94e1192eaf2a241ef1b9d1b8290ac43"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.115/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "4f5a83cef58a7a76cd2c83ea8432206c8a65bb3d31bf12abeea04ae5f0cfb461"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.115/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "846fb35a47699bb6a4d2f7973bcac868e8fe88b4aa1e8d0933250a78ef2fb6b9"
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
