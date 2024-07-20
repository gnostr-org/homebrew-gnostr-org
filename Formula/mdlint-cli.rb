class MdlintCli < Formula
  desc "The mdlint-cli application"
  version "2.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/mdlint/releases/download/v2.0.1/mdlint-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a6e870ded192481594f8493c067e30850b382e11676030438be7c15025cc2551"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/mdlint/releases/download/v2.0.1/mdlint-cli-x86_64-apple-darwin.tar.xz"
      sha256 "415872f6a16974ac385784876525b7f7d44b5ebf8864a58c5b746e021210e1b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/mdlint/releases/download/v2.0.1/mdlint-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6ab00a7d4d680fb275c91c4c3e66fa012e330645394a2fbc214577ffb716f444"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "mdlint-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mdlint-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mdlint-cli"
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
