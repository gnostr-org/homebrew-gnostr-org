class GnostrQuery < Formula
  desc "gnostr-query: retrieve nostr events."
  homepage "https://github.com/gnostr-org/gnostr-query"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.4/gnostr-query-aarch64-apple-darwin.tar.xz"
      sha256 "7c6b034525962f6b27a36bbf7061b9a48d7e5c1a616c4e391301ac50e9da88b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.4/gnostr-query-x86_64-apple-darwin.tar.xz"
      sha256 "9c7854b4b94fcfb333418aac50bc6b45435bcfe293466b7e6160783e0e267876"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.4/gnostr-query-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c31fc052bfa14865da71068e6d12a4abbb858497e3e880f38d33a64450cce6ce"
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
    bin.install "extract_elements", "gnostr-query" if OS.mac? && Hardware::CPU.arm?
    bin.install "extract_elements", "gnostr-query" if OS.mac? && Hardware::CPU.intel?
    bin.install "extract_elements", "gnostr-query" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
