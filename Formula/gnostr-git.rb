class GnostrGit < Formula
  desc "A command-line application for interacting with git repositories"
  homepage "https://github.com/gnostr-org/gnostr-git"
  version "0.0.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.8/gnostr-git-aarch64-apple-darwin.tar.xz"
      sha256 "79a8a23f3c7c9f9b6c510fffe7d7799d7d8d39b829559918b0353bb0aa8bad8d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.8/gnostr-git-x86_64-apple-darwin.tar.xz"
      sha256 "f11b75b1418b2ac0eef5879d353583af05efb01328c005048c5b8a37a35f459c"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-git/releases/download/v0.0.8/gnostr-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "76482b7ad8a0fb6af7212b1d465f04e5976299b09d7849f4b6d5d1156a7fffe5"
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
