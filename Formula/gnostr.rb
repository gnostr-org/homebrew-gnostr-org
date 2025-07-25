class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.109"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.109/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "369773ca2174be284bce97c2ea1e33e7af2a3fbacdb6609dd44e2b5a7ef03768"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.109/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "d2369f9d53d59563612e543d55410c89e43044318c4df971a0a8fb6c798d4c30"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.109/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "61a2874e11550b23711a035d66ed2b20f5d43602d904200606a165ddcb9fa58c"
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
      bin.install "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-sha256",
"gnostr-weeble", "gnostr-wobble"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-sha256",
"gnostr-weeble", "gnostr-wobble"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-sha256",
"gnostr-weeble", "gnostr-wobble"
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
