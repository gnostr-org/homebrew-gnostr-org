class GnostrCli < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.42"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-cli-aarch64-apple-darwin.tar.gz"
      sha256 "c4b67d7b11b05f1adccd7ef2e2692f74d79daeb4511ea1ce07e7bc95b4eeb6c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-cli-x86_64-apple-darwin.tar.gz"
      sha256 "a61bc7bda6243b28d16875d04918da31f152d9cba60a13446e3f9a9ce9a2d17b"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.42/gnostr-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6414bd8060e5871aea2829584c7e36d0782f438dfd921ea21fd3ebcf1d47ea86"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "git-cli", "gnostr-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-cli", "gnostr-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-cli", "gnostr-cli"
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
