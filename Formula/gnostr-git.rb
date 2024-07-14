class GnostrGit < Formula
  desc "A command-line application for interacting with git repositories"
  homepage "https://github.com/gnostr-org/gnostr-git"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.7/gnostr-git-aarch64-apple-darwin.tar.xz"
      sha256 "1f68c3cba23631501334de0d0d10576d13de0e4d3ed7c191fe5af2028b21b5dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.7/gnostr-git-x86_64-apple-darwin.tar.xz"
      sha256 "9c58f6e8f131e31796f1a450a90377c46a4a9f3f48d320f4456b9f68219c9133"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.7/gnostr-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b5acd35b487d7c9884ebcc423af879d9f4741686ce04b7663ac7f72a792198e2"
    end
  end
  license "MIT OR Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "ein", "gix", "gnostr-git"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ein", "gix", "gnostr-git"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ein", "gix", "gnostr-git"
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
