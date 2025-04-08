class Nips < Formula
  desc "The nips application"
  homepage "https://github.com/gnostr-org/gnostr-nips"
  version "0.0.37"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.37/nips-aarch64-apple-darwin.tar.xz"
      sha256 "b206499f215d0d49d388a4743435db382e3e502427d9140e309f3039a5ce93dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.37/nips-x86_64-apple-darwin.tar.xz"
      sha256 "78cdce0dcf6f0fb193d3aa6a0b0a8386e46ee198653e684ba906668bc6b42fb5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.37/nips-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2c7aefdd2525a4b4a645ed650e1e244dbc43259fa77d8ef40e09fb3e4d469014"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-nips/releases/download/v0.0.37/nips-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4ab743c7e07a6157563fd672ab6793899baaceda2bca1c2ba8acf4fc797cfa9"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "nips" if OS.mac? && Hardware::CPU.arm?
    bin.install "nips" if OS.mac? && Hardware::CPU.intel?
    bin.install "nips" if OS.linux? && Hardware::CPU.arm?
    bin.install "nips" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
