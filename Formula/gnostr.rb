class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.110"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.110/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "5d69291237f6ff3c35ddf66a80e7f95b7ab1dd1c5a1cebf3554db253d4d54d1a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.110/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "611cb6b62679baf9fa14cde34eb1de2c62b3f70d634c3385c0dce50f13d9c0d1"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.110/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4f2c66ed01a8b2b22f3ace9fc5c7c44322852782a38b5f3575dd4e93005fd8f2"
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
