class GnostrQuery < Formula
  desc "The gnostr-query application"
  homepage "https://github.com/gnostr-org/gnostr-query"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.2/gnostr-query-aarch64-apple-darwin.tar.xz"
      sha256 "eb791379ea1405e439e1fc4fb496cf9435d506427defa200758c679dd518a306"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.2/gnostr-query-x86_64-apple-darwin.tar.xz"
      sha256 "3583972ed1cd1cc46061cb90ea14ddad8e955b7d4d5106bcaa11cdcfc08aedff"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-query/releases/download/v0.0.2/gnostr-query-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "29adae74db14b9ef9047c7220d9ff022bcc49eb4a7ea6b2882e69c8e8da5bf71"
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
    bin.install "gnostr-query", "gnostr-query-tui" if OS.mac? && Hardware::CPU.arm?
    bin.install "gnostr-query", "gnostr-query-tui" if OS.mac? && Hardware::CPU.intel?
    bin.install "gnostr-query", "gnostr-query-tui" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
