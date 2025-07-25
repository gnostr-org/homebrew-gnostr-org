class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.111"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.111/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "e1bf3c61da914f98c16bee46da50b05056033e1e20d25992ff815c121787a3e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.111/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "aae9a18575d02ef4771045f8e755bf889a06b47e699c02ab15a597435dee0ea2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.111/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "57dbe4c387d333774d7d26669a26e82d1bde38915843bc044536cdff3075f422"
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
      bin.install "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-query",
"gnostr-sha256", "gnostr-weeble", "gnostr-wobble"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-query",
"gnostr-sha256", "gnostr-weeble", "gnostr-wobble"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-ssh", "git_remote_nostr", "gnostr", "gnostr-blockhash", "gnostr-blockheight", "gnostr-query",
"gnostr-sha256", "gnostr-weeble", "gnostr-wobble"
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
