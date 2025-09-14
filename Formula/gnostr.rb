class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.123"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.123/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "bd1b1449c0fcc91bd6307210a2d2eb69ef1b66d01951d3bd16ef79c3eccddbc5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.123/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "68025854646381d9cdcfcece7e95506e4a9dcc7ab7f5a5210c197ae8050e5a34"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.123/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "33f73cbc33ca915de490c50195fdcc98ac22318613462e811bedbb8d48a6d80f"
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
"gnostr-blockheight", "gnostr-cube", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-relay", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash",
"gnostr-blockheight", "gnostr-cube", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-relay", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "generate-server-config", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash",
"gnostr-blockheight", "gnostr-cube", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-query", "gnostr-relay", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
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
