# apt-bundle Fix Plan

Synthesis of `cloude-apt-bundle-review.md` and `gemini-apt-bundle-review.md`.
Gemini's review is mostly approving — most actionable items come from Claude's review.

## Priority 1 — Real bugs

### 1.1 Restore `software-properties-common`
- **Where**: `apt/apt-bundle:91`
- **Problem**: package is commented out but `add-apt-repository` is invoked at line 140; fresh-system PPA usage fails.
- **Fix**: install `software-properties-common` only when `$TmpDir/ppas` is non-empty (lazy, like `equivs` at line 155). Avoids hard dependency for users who never use `ppa`.

### 1.2 Update PPA "already installed" detection
- **Where**: `apt/apt-bundle:139`
- **Problem**: hardcoded `http://ppa.launchpad.net/$ppa/ubuntu`; modern Ubuntu uses `https://`, `ppa.launchpadcontent.net`, and deb822 `.sources` files. Result: `add-apt-repository` is re-run every time (slow/noisy, not fatal).
- **Fix**: broaden detection — match both `http://` and `https://`, both `ppa.launchpad.net` and `ppa.launchpadcontent.net`, and scan `*.sources` (deb822) in addition to `*.list`.

### 1.3 `meta`: skip `dpkg -i` when already installed at correct version
- **Where**: `apt/apt-bundle:165-181`
- **Problem**: the `[ ! -f "$deb" ] || [ "$current" != "$version" ]` guard only controls *rebuild*. The `dpkg -i` at line 181 runs unconditionally every invocation.
- **Fix**: install only when `current != version`. Keep the `|| true` and the `apt install -f -y` follow-up.

### 1.4 Plain `.deb` URL: skip install when version unchanged
- **Where**: `apt/apt-bundle:189-198`
- **Problem**: `curl -z` avoids re-download, but `dpkg -i` always runs.
- **Fix**: use `dpkg -i --skip-same-version "$destdir/$file"` (simplest; works even when `curl -z` does refresh the file).

## Priority 2 — Shell correctness

### 2.1 Switch shebang to `#!/bin/bash`
- **Where**: `apt/apt-bundle:1`
- **Problem**: script uses `local` (lines 57, 262, 276, 282, 288, 296) and `printf %q` (line 53) — neither is POSIX. `printf %q` will silently produce wrong output under strict `sh`/`dash`.
- **Fix**: change shebang to `#!/bin/bash`. Simpler than purging the bashisms.

### 2.2 Replace `eval` on `/etc/os-release`
- **Where**: `apt/apt-bundle:104`
- **Problem**: `eval "$(sed 's/^/export /' /etc/os-release)"` — unnecessarily evals shell-quoted content.
- **Fix**:
  ```sh
  set -a; . /etc/os-release; set +a
  ```

### 2.3 Multi-line `description` breaks `equivs-build`
- **Where**: `apt/apt-bundle:175` (writing) and `apt/apt-bundle:291` (capture)
- **Problem**: deb control format requires continuation lines to start with a space. Currently a multi-line description from a Debfile produces an invalid control file.
- **Fix**: when emitting `Description:`, prefix every non-first line with a single space. Document the constraint, or sanitize in `meta()`.

## Priority 3 — Nits / cosmetic

- **`apt/apt-bundle:161`**: replace `tr '\n' ',' | sed 's/,\+/,/g; s/^,//; s/,$//'` with `paste -sd,` for readability.
- **`apt/apt-bundle:122`**: no signature verification on dearmored keyrings — threat model is "trust the URL"; document this rather than fix it.
- **`apt/apt-bundle:86`**: `type apt` check happens before `initialize`/`set -e`; harmless, leave as-is.

## Out of scope (Gemini suggestions — declining)

- Configurable paths for `/usr/share/keyrings`, `/etc/apt/sources.list.d`, `/usr/local/bin` — standard locations, YAGNI.
- Replacing `sha1sum` with `shasum -a 1` — `sha1sum` is present on every Debian/Ubuntu.
- Replacing `sudo` with `pkexec` — re-architecture, not a real win.
- `apt satisfy` compatibility — only matters for pre-2016 systems.

## Execution order

1. P1.1, P1.3, P1.4 — straightforward bug fixes.
2. P1.2 — PPA detection rewrite (needs care; test on current Ubuntu/Debian).
3. P2.1 — shebang flip (smallest, unlocks `local`/`printf %q` correctness).
4. P2.2, P2.3 — small correctness tweaks.
5. P3 — only if touching nearby code.

## Verification

- `apt-bundle -n Debfile` (dry-run) on current `apt/Debfile` — check no regressions.
- Re-run `apt-bundle` twice and confirm idempotency: no `dpkg -i` for meta/`.deb` on second run.
- Manual check on a system with at least one PPA already added (via deb822) — confirm `add-apt-repository` is skipped.
