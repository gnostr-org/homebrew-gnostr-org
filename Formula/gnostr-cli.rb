class GnostrCli < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.36"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.36/gnostr-cli-x86_64-apple-darwin.tar.gz"
    sha256 "6010d7d0d983eb1362cf542a41d8b900651c5729f5761b35bd169481457318f8"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.36/gnostr-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ab9f93eb8f380aa0bcc0b9ea205237261769e283d6773e10e3442cc2e9a06e47"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "gnostr-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-cli"
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
