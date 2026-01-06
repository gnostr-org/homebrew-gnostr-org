class Gtr < Formula
  desc "rust implementation of gittorrent"
  homepage "https://github.com/RandyMcMillan/gtr"
  version "0.0.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.10/gtr-aarch64-apple-darwin.tar.xz"
      sha256 "b61e461c3ccd8820c169e7c1235ce147fec9cbfdb10beeec85ad59a2347ecac5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.10/gtr-x86_64-apple-darwin.tar.xz"
      sha256 "0ca0b744663d2dd14a1973a8fbccb1fe41739b7fd84a70cef3426c68a761fd89"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.10/gtr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef45d0b109a734a213421b08e59a629606e4d25ef1c6da43b19109929e1b0112"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/gtr/releases/download/v0.0.10/gtr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4f8bb34398b8b7317fbbb02106f6f4b6e2ab11287d03baa1346fcd659a3309a7"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "gtr" if OS.mac? && Hardware::CPU.arm?
    bin.install "gtr" if OS.mac? && Hardware::CPU.intel?
    bin.install "gtr" if OS.linux? && Hardware::CPU.arm?
    bin.install "gtr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
