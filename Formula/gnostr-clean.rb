class GnostrClean < Formula
  desc "Quickly clean up your development directories on disk"
  homepage "https://github.com/gnostr-org/gnostr-clean"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-clean/releases/download/v0.0.4/gnostr-clean-aarch64-apple-darwin.tar.xz"
      sha256 "c268d04e7b9368dcca79f4ac1ed3b2fc5926df5613d2122acf4b6deabf5c60ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-clean/releases/download/v0.0.4/gnostr-clean-x86_64-apple-darwin.tar.xz"
      sha256 "829daba773b249f9dc4f7af7595b7e96bc59372698a652cf471a5cf1bea72b52"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-clean/releases/download/v0.0.4/gnostr-clean-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1ae875563c7366796709e4457cbf35a040333748ccf7b5e2b8b0f090f9274ad9"
  end
  license "MIT"

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
    bin.install "gnostr-clean" if OS.mac? && Hardware::CPU.arm?
    bin.install "gnostr-clean" if OS.mac? && Hardware::CPU.intel?
    bin.install "gnostr-clean" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
