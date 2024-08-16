class GnostrHello < Formula
  desc "gnostr-hello: extrememly simple async web service in rust"
  homepage "https://github.com/gnostr-org/gnostr-hello"
  version "0.0.6"
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-hello/releases/download/v0.0.6/gnostr-hello-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eecce8639428c60be93294e86ebd643aab4d90c709cd17b15da18811e22cd5b7"
    end
  end

  BINARY_ALIASES = {"x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr-genkey", "gnostr-hello"
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
