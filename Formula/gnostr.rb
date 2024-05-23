class Gnostr < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.44"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "abab1b6d3d3d9c6d6c00a2ff1292a051c75019242490ad177b00862c8705a6b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "a0cef580944b041e196e059a2a9b2d6f35a1d62ca73e37004f29acc1eccb3f96"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.44/gnostr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ed4b90998e33007597bcfae7fe38584a515552e49d3ec8a8e9493f9618da6e64"
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
