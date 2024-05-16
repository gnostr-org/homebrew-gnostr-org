class GnostrTui < Formula
  desc "blazing fast terminal-ui for git"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.39"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.39/gnostr-tui-x86_64-apple-darwin.tar.gz"
    sha256 "a57ed2438810fd0c26d99e9585a98a6b4873b9b935ee45689c1c8e32c95c1c2f"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.39/gnostr-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3baf1b3fb0326ab5ee2078375b14f6b54bf60861f76b1a353c911c008a9e662a"
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
      bin.install "gnostr-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-tui"
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
