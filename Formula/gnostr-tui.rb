class GnostrTui < Formula
  desc "blazing fast terminal-ui for git"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.45"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-tui-aarch64-apple-darwin.tar.gz"
      sha256 "0d7fbbd5319bd63b59eb624094850b843df2a12819038d8a3674bac374cd33bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-tui-x86_64-apple-darwin.tar.gz"
      sha256 "b1368e3c5841f0ebcff744ed1bbcb80e15cec1c4f5a11258fd534b0d86f8d27d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostr-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2359eb82f0ea031b6166f274be75ba7251f9ae96bd293b7644474e0bab3ee5d8"
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
