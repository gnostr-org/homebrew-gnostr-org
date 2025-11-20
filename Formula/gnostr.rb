class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "1907.924459.723348"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v1907.924459.723348/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "92f035d74aeb853ba7e0e50f47812280ac64db66be89215f6ef749e26c5be9e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v1907.924459.723348/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "cf2ee3a670199ca65878b512e9f7f403d90f4c8db1a2dc7f0205e4d93579fa63"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v1907.924459.723348/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "e2d02b212ffd8ef973ee0a917e6a937bf5b1430a8e2b5b9ea60dd09deca72823"
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
      bin.install "generate-server-config", "git-checkout-b", "git-checkout-pr", "git-remote-nostr", "git-tag",
"git-tag-pr", "git-tag-version", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git-checkout-b", "git-checkout-pr", "git-remote-nostr", "git-tag",
"git-tag-pr", "git-tag-version", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git-checkout-b", "git-checkout-pr", "git-remote-nostr", "git-tag",
"git-tag-pr", "git-tag-version", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
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
