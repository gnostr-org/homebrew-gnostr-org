class GnostrTui < Formula
  desc "blazing fast terminal-ui for git"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.50"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/gnostr-tui-aarch64-apple-darwin.tar.gz"
      sha256 "a0419a73c609e3e0278454d9aacb0c3b8c34c60f44a823cc5c8addad6a27c1ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/gnostr-tui-x86_64-apple-darwin.tar.gz"
      sha256 "60bda96f29cd7fbed096057e825bcd52cf9ef289bf77b10a164e36599f06ffeb"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.50/gnostr-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2cd4270556b9c0ab5f0f7f82b84ae31333374a1ec0035468c5d0d992eb7d0959"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "git-tui", "gnostr-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-tui", "gnostr-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-tui", "gnostr-tui"
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
