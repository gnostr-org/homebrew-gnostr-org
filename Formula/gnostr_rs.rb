class GnostrRs < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr_rs"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr_rs/releases/download/v0.0.5/gnostr_rs-aarch64-apple-darwin.tar.xz"
      sha256 "17a261bde850b056ca567847b4e64b406befcb32177adb9dc95466dbee909777"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_rs/releases/download/v0.0.5/gnostr_rs-x86_64-apple-darwin.tar.xz"
      sha256 "816c16e3f3aeb1f4c94e72767dd1a83b7f03372c230537f9a4485fdce20ea908"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr_rs/releases/download/v0.0.5/gnostr_rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb297b710084e3f0a0b4ecaf620c75cdebd662794f26c832bd4e2e5a1d4bd150"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "gnostr", "gnostr_dashboard"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gnostr", "gnostr_dashboard"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gnostr", "gnostr_dashboard"
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
