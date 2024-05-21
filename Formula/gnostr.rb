class Gnostr < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.44"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "1c5b4c008b8cafe09e9da1de9beaf1815324d38494c9b0714696fcc7a94b5fcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "db60230a5e871a8b1adaea6e3fd1aa07d7ee9033e7894261102ec9d8789744ed"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e6a239e958a386900cf5e5d80b456f94bd79f46e320a0b04895700e98a04f5ff"
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
      bin.install "git-gnostr", "git-nostril", "gnostr"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-gnostr", "git-nostril", "gnostr"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-gnostr", "git-nostril", "gnostr"
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
