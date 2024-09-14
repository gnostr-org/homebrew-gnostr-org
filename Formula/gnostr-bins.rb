class GnostrBins < Formula
  desc "git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr-bins"
  version "0.0.50"
  if OS.mac?
    url "https://github.com/gnostr-org/gnostr-bins/releases/download/v0.0.50/gnostr-bins-x86_64-apple-darwin.tar.xz"
    sha256 "629633e3c178bb4815552291928413fe4cdb96335c3a8681ec93ba23bf5564a9"
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-bins/releases/download/v0.0.50/gnostr-bins-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ce081c2f4458a5c6521a13f3c35ecd97809b492733c7cd9f4681806beb3ee7b2"
    end
  end
  license "Apache-2.0"
  
  depends_on "openssl@3"
  depends_on "openssl@3"
  depends_on "openssl@3"
  depends_on "openssl@3"

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
      bin.install "bech32_to_any", "decrypt_private_key", "dump_relay", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_kind_and_author", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_event_addr", "generate_keypair", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-init", "gnostr-legit", "gnostr-log", "gnostr-ls-remote", "gnostr-objects", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-state", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "post_event", "privkey_to_bech32", "pubkey_to_bech32", "verify_keypair"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bech32_to_any", "decrypt_private_key", "dump_relay", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_kind_and_author", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_event_addr", "generate_keypair", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-init", "gnostr-legit", "gnostr-log", "gnostr-ls-remote", "gnostr-objects", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-state", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "post_event", "privkey_to_bech32", "pubkey_to_bech32", "verify_keypair"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bech32_to_any", "decrypt_private_key", "dump_relay", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_kind_and_author", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_event_addr", "generate_keypair", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-init", "gnostr-legit", "gnostr-log", "gnostr-ls-remote", "gnostr-objects", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-state", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "post_event", "privkey_to_bech32", "pubkey_to_bech32", "verify_keypair"
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
