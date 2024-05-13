class GnostrTui < Formula
  desc "blazing fast terminal-ui for git"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.32"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.32/gnostr-tui-x86_64-apple-darwin.tar.gz"
    sha256 "596362127ca80de7921395ccdd04596050d1c60308d508cf381a481bfa6f4167"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.32/gnostr-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0992a9ad76e162ab0bf4eebe08367bf6666378cb43e7d1a4dd313a5c5d799412"
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
