# gnostr-org/gnostr-org

## How do I install these formulae?

`brew install gnostr-org/gnostr-org/<formula>`

Or `brew tap gnostr-org/gnostr-org` and then `brew install <formula>`.

# Homebrew Tap for Nostr

This is a [homebrew tap](https://docs.brew.sh/Taps) for [nostr](https://nostr.com/) software, such as [gossip](https://github.com/mikedilger/gossip).

## How do I install these formulae?

First install [homebrew](https://brew.sh/). Then add the tap:

```
brew tap nostorg/nostr
```

Finally install a `<formula>` or `<cask>` (such as `gossip` or `lume`):

```
brew install <formula>
```

### How do I install `gossip`?

To install the latest stable version:

```
brew install gossip
```

To install the latest development branch:

```
brew install --HEAD gossip
```

To install the cask (DMG/Application release build):

```
brew install --cask gossip
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

---

### REQ

```json
["REQ", "gnostr-query", {"authors": ["a34b99f22c790c4e36b2b3c2c35a36db06226e41c692fc82b8b56ac1c540c5bd"], "kinds": [40010]}]
```

### EVENT

```json
["EVENT",{"id": "2ebc74f0c7de2190b0b6b4193bca3b1828138fd15629359bd398f3efcce95711","pubkey": "d4d8d344469f0467a0b85bd78366531737a03f9de17b1131a22fbfdeed4fe2b6","created_at": 1694902849,"kind": 1,"tags": [["weeble","2097"],["wobble","455547"],["blockheight","808034"]],"content": "diff --git a/.gitignore b/.gitignore\nnew file mode 100644\nindex 0000000..d0a3534\n--- /dev/null\n+++ b/.gitignore\n@@ -0,0 +1 @@\n+.gnostr\ndiff --git a/nevent1qqsryv4s3lvf339wnfpkw4jh5jxqpzf6e8cwnjygslwd9q86vte6mkspz3mhxue69uhhyetvv9ujuerpd46hxtnfduyyt8h5 b/nevent1qqsryv4s3lvf339wnfpkw4jh5jxqpzf6e8cwnjygslwd9q86vte6mkspz3mhxue69uhhyetvv9ujuerpd46hxtnfduyyt8h5\nnew file mode 100644\nindex 0000000..e69de29","sig": "e5b4ef57ec49546079617b3e60d2ad0ed1fcf1322dcf06c9851c2a6e6c05840a32fff5072636e4e6699a94d21f9ce3728404e966e00a126cd662f4146d4ce2d8"}]
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
