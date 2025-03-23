class GnostrQuery < Formula
  desc "The gnostr-query application"
  homepage "https://github.com/gnostr-org/gnostr-query"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.3/gnostr-query-aarch64-apple-darwin.tar.xz"
      sha256 "b39cbf187b949be0ac81d5cb4253923bef537b32d3b6a150091fbfd89d27c0be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.3/gnostr-query-x86_64-apple-darwin.tar.xz"
      sha256 "8ce23bb3e222fe0816cbdcd3bc05509aa0ec794b704ace3e94b2c254fa605f01"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.3/gnostr-query-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "e7c91dc68097a8f89043ac7e3c58bc61053018ce4cd0da8652ff2e6f5777650a"
  end

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
