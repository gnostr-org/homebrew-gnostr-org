class Nips < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.36"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.36/nips-x86_64-apple-darwin.tar.gz"
    sha256 "f8d7681867223060b014c6166e5cd093418118f322500f429083a92bcc2ca135"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.36/nips-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f87f237fa013167b4bcee03204f4e259d4db7460c41219ac9f3b73642214a65"
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
      bin.install "nips"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nips"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nips"
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
