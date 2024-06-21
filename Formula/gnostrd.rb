class Gnostrd < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.45"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostrd-aarch64-apple-darwin.tar.gz"
      sha256 "46f8f28a2cbbcdf721124950f667b494a6998c3a1c27a8ba14f26c3eb073880c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostrd-x86_64-apple-darwin.tar.gz"
      sha256 "e255d2ed56f6667e63d2ce152b9917a75f54484a473b7c28d54e8155865d30aa"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.45/gnostrd-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e2ff64babc972fed86d5fce12b3efcc7ab97ceb923be5a75724282e8d3c815ee"
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
      bin.install "gnostr--d", "gnostr-chat", "gnostr-d", "gnostrd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr--d", "gnostr-chat", "gnostr-d", "gnostrd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr--d", "gnostr-chat", "gnostr-d", "gnostrd"
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
