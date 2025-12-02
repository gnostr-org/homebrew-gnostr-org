class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "1905.926180.332424"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v1905.926180.332424/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "680da4fafb2b186ae95967ca99f3a99e5ea75f3ac52881b1d96cd2cb2a0592e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v1905.926180.332424/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "65db52fef9c80183dd5c465f19d72e9bb9023cf96d818679dd8402aa0e336c88"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v1905.926180.332424/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "bb5b08de365f779c485a5bb40a8ec6edaae696fe501dcbee86ce8507ae23913f"
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
      bin.install "capture_tui", "generate-server-config", "git-remote-nostr", "git-tag", "git-tag-pr",
"git-tag-version", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-client", "gnostr-dashboard", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-lookup", "gnostr-query", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "capture_tui", "generate-server-config", "git-remote-nostr", "git-tag", "git-tag-pr",
"git-tag-version", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-client", "gnostr-dashboard", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-lookup", "gnostr-query", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "capture_tui", "generate-server-config", "git-remote-nostr", "git-tag", "git-tag-pr",
"git-tag-version", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-client", "gnostr-dashboard", "gnostr-genssh", "gnostr-kvs", "gnostr-legit", "gnostr-lookup", "gnostr-query", "gnostr-sha256", "gnostr-sniper", "gnostr-weeble", "gnostr-wobble", "screenshot", "server-toml"
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
