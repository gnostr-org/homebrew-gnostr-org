class GnostrGui < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.36"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.36/gnostr-gui-x86_64-apple-darwin.tar.gz"
    sha256 "8e474cb7509b81199dc81c8daaa29079a8edcb96f581ccdad154da2452ef2712"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.36/gnostr-gui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a299015731cef43ecc23cbf266afea789c6ff48de27f90be18ef1ccd6a7a08c"
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
      bin.install "gnostr-gui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr-gui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-gui"
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
