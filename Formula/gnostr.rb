class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "1912.920900.732280"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v1912.920900.732280/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "fa9eec9487ee707f9541c569cda2fb95cfffdbee79a71836b75fed3ff10a3214"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v1912.920900.732280/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "92c383f0cf2315cca4eba8d38ffbd96aa0fd3d7656dae1fe5d6f83b131dd22bf"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v1912.920900.732280/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "9f9504d9d6edce257ed8a7828bbd47eb9960e386d456366a3fbb255be86a41c3"
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
      bin.install "generate-server-config", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight",
"gnostr-cube", "gnostr-genssh", "gnostr-git-checkout-b", "gnostr-git-checkout-pr", "gnostr-git-tag", "gnostr-git-tag-pr", "gnostr-git-tag-version", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-relay", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight",
"gnostr-cube", "gnostr-genssh", "gnostr-git-checkout-b", "gnostr-git-checkout-pr", "gnostr-git-tag", "gnostr-git-tag-pr", "gnostr-git-tag-version", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-relay", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight",
"gnostr-cube", "gnostr-genssh", "gnostr-git-checkout-b", "gnostr-git-checkout-pr", "gnostr-git-tag", "gnostr-git-tag-pr", "gnostr-git-tag-version", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-relay", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
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
