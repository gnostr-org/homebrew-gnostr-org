class GnostrGui < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.42"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-gui-aarch64-apple-darwin.tar.gz"
      sha256 "e96c46f701dd434b407ddf8e305202d9ce75eaea62a5152eaa369d8751bc39a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-gui-x86_64-apple-darwin.tar.gz"
      sha256 "87e4ec09d859ab3d2a983a3c45e4be51b9dc94c7e4a49d0d67de1e3c59a1420f"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-gui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "26d957c51178f02b661facb13578c26fb2772a43a180e414ae96dca15de1d12d"
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
