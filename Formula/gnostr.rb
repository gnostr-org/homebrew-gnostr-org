class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.90"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.90/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "aaa118e0097d1833522ef79a90ea32023a6b35817f2ca85c55ad1c338541518f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.90/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "9ba85f18304ee66e6aa7783f18b16956c5d6a0d9dd91a44a69b597ae9702ad7e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.90/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "18e31b5ec7b4861346d742ba05eee34a62b521343a1b664953af6a1bd13341d1"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "bech32_to_any", "create_event", "create_event_raw", "create_giftwrap", "create_nevent",
"decrypt_private_key", "dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "generate_keypair", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "test_relay", "verify_event", "verify_keypair"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bech32_to_any", "create_event", "create_event_raw", "create_giftwrap", "create_nevent",
"decrypt_private_key", "dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "generate_keypair", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "test_relay", "verify_event", "verify_keypair"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bech32_to_any", "create_event", "create_event_raw", "create_giftwrap", "create_nevent",
"decrypt_private_key", "dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "generate_keypair", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "test_relay", "verify_event", "verify_keypair"
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
