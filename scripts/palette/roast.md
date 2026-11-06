# Roast of `scripts/palette`

You built an entire zero-dependency color-science laboratory—complete with sRGB linearization, WCAG 2.1 luminance, WCAG 3.0 draft APCA (`Lc`), CIELAB, the 25-line `ciede2000` monster formula, and Viénot 1999 protan/deutan color-blindness simulation matrices in `lib/deltae.py`—just to run it on `palettes.py` and **ignore every single warning your own math screams at you.**

---

## 1. The Colors: Why Build a Linter If You Leave All the Errors In?

### `AQUA_NIGHT`: A "Dark Theme" Where Your Own Tool Flags Every Accent with an Asterisk of Shame
When you run `deltae.report` on `AQUA_NIGHT`, your own script prints a `*` next to **every single accent color** (`red *`, `green *`, `yellow *`, `blue *`, `magenta *`, `cyan *`) because **none of them reach `|Lc| >= 60`** against `#3d3b41`:
* **The 5.45:1 Participation Trophy:** In `AQUA_NIGHT`, `ansi_red` (`5.48:1`), `ansi_yellow` (`5.47:1`), `ansi_blue` (`5.46:1`), `ansi_cyan` (`5.45:1`), and `bright_green` (`5.51:1`) are all suspiciously tuned to ~`5.47:1` WCAG contrast (`Lc ~ -54.7`). You clearly tuned them to pass WCAG 2.x AA (`4.5:1`), then added `lib/apca.py` later, discovered that WCAG 2 overstates contrast on dark backgrounds and that `Lc -54` is only good for `"Large"` text (failing `"Content"` at 60 and `"Body"` at 75), and just... walked away.
* **Copy-Pasting Day Green into Night:** `AQUA_NIGHT["ansi_green"]` is `#1e763c`—literally the exact same dark forest green hex code as `AQUA_DAY["ansi_green"]`. On a `#3d3b41` dark gray background, that gives a **1.95:1 WCAG FAIL** (`Lc -15.4`). Hope you never run `git diff` or `ls` using slot 2 in dark mode!
* **Stealth Magenta:** `AQUA_NIGHT["ansi_magenta"]` and `bright_magenta` are both `#8a3aa4`. Against `#3d3b41`, that is a **1.70:1 WCAG FAIL** and **`Lc -11.8` APCA FAIL** (literally below the human threshold for *non-text* spot elements). And because `ansi_magenta == bright_magenta`, making text bold/bright won't save you either.

### "16 Colors" That Are Actually 9 Colors in a Trenchcoat
In `lib/apps/wezterm.py`, you left a history lesson in the template comment:
> `# Before 16 colors, there were 8 colors: black, red, green, yellow, blue, magenta, cyan, and white. The other 8 were added as their bright variants.`

And then in `AQUA_DAY`:
* `ansi_red == bright_red` (`#b31367`)
* `ansi_green == bright_green` (`#1e763c`)
* `ansi_blue == bright_blue` (`#15609f`) — plus `cursor` is *also* `#15609f`, and you left `# "bright_blue": "#015493"` commented out like a crime scene chalk outline.
* `ansi_magenta == bright_magenta` (`#75228e`)
* `ansi_cyan == bright_cyan` (`#007474`)
* `ansi_white == normal` (`#424242`)

And in `AQUA_NIGHT`, `red`, `yellow`, `blue`, `magenta`, and `cyan` are identical between `ansi_*` and `bright_*`. Why have 16 ANSI slots if `ansi` and `bright` are just copy-pasted?
Even better: in `AQUA_DAY`, `ansi_yellow` (`#926414`, lighter, fails WCAG AA at `4.34:1`) is **brighter** than `bright_yellow` (`#825400`, darker, passes AA at `5.48:1`).

### Naming Inversion Wonderland
* In `AQUA_DAY` (a light theme):
  * `ansi_black` is `#d1d1d1` (light silver, `1.28:1` invisible on `#ebebeb`).
  * `ansi_white` is `#424242` (charcoal).
  * `bright_white` is `#002338` (**deep abyssal navy**, the darkest color in the entire palette at `13.58:1`). Calling `#002338` "bright white" is psychological warfare against any terminal CLI tool that hardcodes ANSI 30 or 37/97 assuming black is dark and white is light.
  * `extra_white` is `#6f8396` (slate blue-gray). Not extra, and definitely not white.
* Duplicate keys pretending to be a semantic system:
  * `selection == extra_gray0` in both themes (`#dfdfe1` / `#404446`), and both have `0.0 Lc` contrast against `background` (`1.12:1` WCAG).
  * `ansi_black == extra_gray1` in both themes (`#d1d1d1` / `#494d4f`).
  * `bright_black == extra_gray3` in `AQUA_NIGHT` (`#adb5bf`).
  * And then in `lib/apps/gty.py` and `lib/apps/wezterm.py`, you don't even use `${selection}` for terminal selection—you map `selection` to `${extra_gray1}` (`1.28:1` contrast, `Lc 12.6` FAIL) and map WezTerm's `split` to `${selection}`!

### Color-Blindness Checks That Actively Roast You
You wrote a whole `simulate` pipeline for protanopia and deuteranopia, and your own report outputs:
* **Aqua Day:**
  * `blue` vs `magenta` in deutan: **ΔE 4.1 (FAIL)** — practically indistinguishable.
  * `green` vs `yellow` in protan/deutan: **ΔE 9.2 / 10.1 (FAIL)**.
  * `red` vs `magenta` in protan: **ΔE 9.8 (FAIL)**.
* **Aqua Night:**
  * `green` (`#7fc78e`) vs `yellow` (`#dbaf75`) in protan/deutan: **ΔE 4.6 / 8.0 (FAIL)** — they turn into the exact same muddy beige.
  * `red` (`#ff97be` — which is really bubblegum pink) vs `cyan` (`#7cc2c2`) in protan/deutan: **ΔE 7.3 / 9.5 (FAIL)** — because `#ff97be` has so much blue (`be`) and green (`97`) mixed in that without red cones it collapses right into `#7cc2c2`.
  * `normal` (`#dde2e4`) vs `red` (`#ff97be`) in deutan: **ΔE 8.9 (FAIL)** — pastel pink on pastel gray-white disappears for deuteranopes.

---

## 2. The Code & Generator Bugs

* **Broken Neovim Generation:**
  Comment at line 2 of `palettes.py`:
  `# aqua ships two variants: aqua_day (light) and aqua_night (dark).`
  Line 74 of `palettes.py`:
  `VARIANTS = {"Aqua Day": AQUA_DAY, "Aqua Night": AQUA_NIGHT}`
  When `nvim.generate` runs, it writes `palette_Aqua Day.lua` and `palette_Aqua Night.lua` (with spaces in a Lua module filename!), while `vim/.config/nvim/lua/palette.lua` still does `require("palette_aqua_night")` and `require("palette_aqua_day")`—meaning your `-gen` flag has been writing to orphaned files while Neovim loads stale files from an older commit.
* **Two Different sRGB Transfer Functions in Two Adjacent Files:**
  `wcag.luminance` and `deltae.linear` use the piecewise IEC 61966-2-1 sRGB curve (`c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4`), while `apca.luminance` uses the simple `(c / 255) ** 2.4` power law. While that actually matches the APCA 0.0.98G-4g spec vs WCAG 2.x spec, having three separate hex-parsing `int(color[i : i + 2], 16)` loops across three files in a 4-file `lib/` is peak copy-paste engineering.
* **Single-Dash Long Flags (`-gen`, `-wcag`, `-apca`, `-deltae`):**
  In `palette.py`, you used single dashes for multi-letter flags like `go`'s `flag` package inside Python's `argparse`, which means `-gen` works, `--gen` crashes, and anyone trying to combine short flags gets a surprise.
* **`$EINS` in `colortest.sh`:**
  Classic 2003 TLDP copy-paste artifact where `$EINS` is an uninitialized variable from a German author's script ("eins" = one) that expands to nothing on every loop iteration.
