# apt-bundle Fix Plan

Synthesis of `cloude-apt-bundle-review.md` and `gemini-apt-bundle-review.md`.
Gemini's review is mostly approving — most actionable items come from Claude's review.

## Priority 1 — Real bugs

### 1.1 Restore `software-properties-common` — DONE (no-op)
- **Where**: `apt/apt-bundle:90`
- **Status**: premise wrong — package is already in the eager install list (`apt-transport-https software-properties-common curl gpg`). No bug. Lazy-install refactor declined as YAGNI.

### 1.2 Update PPA "already installed" detection — DONE
- **Where**: `apt/apt-bundle:137-141`
- **Fix applied**: replaced awk-on-`.list` scan with `grep -qrE` matching `https?://ppa\.launchpad(content)?\.net/${ppa}/ubuntu` across the whole `sources.list.d/` (covers `.list` and deb822 `.sources`).

### 1.3 `meta`: skip `dpkg -i` when already installed at correct version — DONE
- **Where**: `apt/apt-bundle:163-182`
- **Fix applied**: outer `if [ "$current" != "$version" ]` now wraps both rebuild and `dpkg -i`. Rebuild stays guarded by `[ ! -f "$deb" ]` inside. `|| true` and `apt install -f -y` preserved.

### 1.4 Plain `.deb` URL: skip install when version unchanged — DONE
- **Where**: `apt/apt-bundle:196`
- **Fix applied**: `dpkg -i` → `dpkg -i --skip-same-version`.

## Priority 2 — Shell correctness

### 2.1 Switch shebang to `#!/bin/bash` — DONE
- **Where**: `apt/apt-bundle:1`
- **Fix applied**: `#!/bin/sh` → `#!/bin/bash`.

### 2.2 Replace `eval` on `/etc/os-release` — DONE
- **Where**: `apt/apt-bundle:103`
- **Fix applied**: `eval "$(sed 's/^/export /' /etc/os-release)"` → `set -a; . /etc/os-release; set +a`.

### 2.3 Multi-line `description` breaks `equivs-build` — DONE
- **Where**: `apt/apt-bundle:175`
- **Fix applied**: emit `Description:` via `printf … | sed '2,$ { s/^$/./; s/^/ /; }'` so continuation lines get a leading space and empty lines become ` .` per deb control format.

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
