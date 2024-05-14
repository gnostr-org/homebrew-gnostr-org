class JjCli < Formula
  desc "gnostr: a git+nostr workflow utility."
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.34"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.34/jj-cli-x86_64-apple-darwin.tar.gz"
    sha256 "755e179b873a10a70d4bc55d83f0bbdf5f6652ddcaacff4b070c06f995d8784f"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.34/jj-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d09c662f2ce95855dde1ee1c86eada6b058c5365f0430edc99902c0c703848be"
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
      bin.install "fake-diff-editor", "fake-editor", "gnostr", "gnostr-jj", "gnostr-jj-gui", "jj"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fake-diff-editor", "fake-editor", "gnostr", "gnostr-jj", "gnostr-jj-gui", "jj"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fake-diff-editor", "fake-editor", "gnostr", "gnostr-jj", "gnostr-jj-gui", "jj"
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
