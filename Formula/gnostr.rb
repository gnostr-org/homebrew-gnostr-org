class Gnostr < Formula
  desc "gnostr:a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr"
  version "0.0.102"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.102/gnostr-aarch64-apple-darwin.tar.xz"
      sha256 "1912c28f562001887ee215833758bafc20599f91f5b47644cdeb9ef7fe2ab872"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.102/gnostr-x86_64-apple-darwin.tar.xz"
      sha256 "ca3fdc116bc445c51b32b65c849e96883100c6888dd76571e82289054f0be3b6"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr/releases/download/v0.0.102/gnostr-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "798eac9fab0b90521eb38b9c8f225afdc4977f526a3af90e393fbee469398a9f"
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
      bin.install "create_event", "create_event_raw", "create_giftwrap", "create_nevent", "decrypt_private_key",
"dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-id-with-login", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-reflog", "gnostr-remote", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "verify_event", "verify_keypair"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "create_event", "create_event_raw", "create_giftwrap", "create_nevent", "decrypt_private_key",
"dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-id-with-login", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-reflog", "gnostr-remote", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "verify_event", "verify_keypair"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "create_event", "create_event_raw", "create_giftwrap", "create_nevent", "decrypt_private_key",
"dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "git-ssh", "git_remote_nostr", "gnostr", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-id-with-login", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-reflog", "gnostr-remote", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "verify_event", "verify_keypair"
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
