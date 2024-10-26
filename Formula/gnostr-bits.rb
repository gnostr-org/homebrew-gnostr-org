class GnostrBits < Formula
  desc "A bittorrent service for gnostr."
  homepage "https://github.com/gnostr-org/gnostr-bits"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-bits/releases/download/v0.0.4/gnostr-bits-aarch64-apple-darwin.tar.xz"
      sha256 "c4dc15ee9005f3045f5cb13a4128aaf823ad3da583e037ffb3d537458dbc6452"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-bits/releases/download/v0.0.4/gnostr-bits-x86_64-apple-darwin.tar.xz"
      sha256 "8a3a9e9e55f782b84b38452503f04d6ca3aa1c1832e68049ee155ddbd7e17694"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-bits/releases/download/v0.0.4/gnostr-bits-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "04e820d4a54151f4ca3d6dec75c76a841765ded9cefdfc28dc7f1311f4d8a304"
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

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
    bin.install "gnostr-bits" if OS.mac? && Hardware::CPU.arm?
    bin.install "gnostr-bits" if OS.mac? && Hardware::CPU.intel?
    bin.install "gnostr-bits" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
