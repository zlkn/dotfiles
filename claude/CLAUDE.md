# Dev Workflow

Use this guide for SCOREWARRIOR branch names, commit messages, Merge Request (MR) titles/descriptions, merge preparation, and changelog updates.

All MR content must be in English.

## Be Brief

Keep answers short and concise. Write concisely in chat replies, MR descriptions, Slack messages, commit messages, YouTrack tasks/comments, and code comments.

- Lead with the main point.
- Remove filler.
- Prefer bullets over long paragraphs.
- Add detail only when it affects a decision or is explicitly requested.

### Code Comments

Reach for a clearer name before reaching for a comment. **One sentence, one or two lines — never a paragraph.** A comment spanning three or more lines is a defect.

- Comment only what the code cannot say: traps, non-obvious ordering, why an unusual API or type was chosen, members that look dead but are seams for future work.
- Delete doc comments that restate a name, and every "which is what lets…" tail.
- Squash the paragraph comments you pass through, not only the ones you would write.
- Keep a comment with the code it describes; never leave one stranded above code that changed.
- Do not match a verbose surrounding file — that style is what this rule exists to stop reproducing.
- Applies to tests, shaders and config examples too, not just production code.

## Workflow

Follow these steps when preparing a branch, commit, MR, changelog, or merge:

1. Run the Preflight check.
2. Synchronize Git when branching, rebasing, or merging (see Git Synchronization).
3. Identify the YouTrack task ID, if one exists.
4. Choose the Conventional Commit type.
5. Define the scope (see Scope and Component).
6. Format the title.
7. Apply the 72-character first-line limit.
8. Name the branch (see Branch Naming).
9. Check whether `CHANGELOG.md` requires an update (see Changelog).
10. Verify merge readiness before merge or rebase operations (see Merge Safety).

Use `glab` for GitLab operations (see GitLab CLI).

## Preflight

Before switching branches, pulling, rebasing, merging, or branching from the default branch:

```fish
git status --short
```

If the worktree is dirty, stop and decide whether to commit, stash, or continue on the current branch.

## Git Synchronization

Before creating a branch, rebasing, or merging, ensure the local default branch is synchronized:

```fish
set DEFAULT_BRANCH (git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
test -n "$DEFAULT_BRANCH"; or set DEFAULT_BRANCH main

git checkout $DEFAULT_BRANCH
git pull --ff-only
```

Proceed only after the default branch is up to date.

## Commit and MR Title Format

Based on [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

```text
type(DO-XXXX/component): description
```

The scope starts with the YouTrack task ID (`DO-XXXX`). When no task exists, use
`duty` (see YouTrack Tasks). Optionally append the affected component after a
slash: `DO-XXXX/component`.

### Rules

- `type` is required.
- `scope` is required and starts with the task ID (`DO-XXXX`) or `duty`.
- Optionally append the component after a slash: `DO-XXXX/component`.
- `DO-XXXX` is uppercase; `duty` and the component are lowercase.
- `description` must start immediately after `type(scope):`.
- `description` must be lowercase.
- Do not end the description with a period.
- Keep the first line under 72 characters.
- If shortening is needed, shorten the description first.
- Do not remove the type or scope.
- Use `!` after the scope for breaking changes.

### Breaking Changes

Use `!` immediately after the scope:

```text
feat(DO-4001/auth)!: drop support for old auth endpoint
```

Breaking changes must be mentioned in the MR description and changelog when the repository has a changelog-managed versioned artifact.

### Allowed Types

`feat, fix, perf, refactor, docs, test, build, ci, chore, style`

### Examples

```text
feat(DO-3593/gce): add desired_status variable to compute module
fix(DO-3718/ansible): replace deprecated db/port params
chore(DO-3593/deploy): stop old deploy nodes v1
feat(DO-4162/reg-server): dedicate envoy pods for reg-server
feat(DO-4001/auth)!: drop support for old auth endpoint
chore(duty): rotate deploy key
```

## Scope and Component

The scope starts with the task ID (`DO-XXXX`) or `duty`. Optionally append the
affected component after a slash: `DO-XXXX/component`.

When choosing a component:

1. Use the primary changed component, module, service, or directory.
2. Keep it short and lowercase.
3. Avoid generic terms such as `misc`, `general`, or `repo`.

Example components: `gce`, `ansible`, `deploy`, `k8s`, `api`, `ci`, `docs`.

### Shortening Example

Shorten the description (not the type or scope) to fit under 72 characters:

```text
# too long
feat(DO-3593/gce): add desired_status variable to the compute module for staging

# shortened description
feat(DO-3593/gce): add desired_status variable to compute module
```

## Branch Naming

Use one of these formats:

```text
DO-XXXX/branch-description
duty/branch-description
```

Prefix choice follows YouTrack Tasks rules. The description must be lowercase kebab-case, short, and aligned with the MR title.

### Examples

```text
DO-3593/add-desired-status-to-gce-module
duty/update-envoy-gateway-chart
```

## GitLab CLI

Use `git mrtm` to create merge requests (it pushes the branch and opens the MR).

Use `glab` for all other GitLab operations: MR updates, pipeline checks, approvals, and merge actions.

Before MR or pipeline operations:

```fish
glab auth status
```

If `glab` is unavailable or unauthenticated, stop and ask for setup.

## Merge Safety

Before merging or rebasing:

1. Run the [Preflight](#preflight) check.
2. Run [Git Synchronization](#git-synchronization) for the default branch.
3. Return to the working branch.
4. Rebase or merge only after the default branch is up to date.

Do not merge or rebase with unresolved local changes unless explicitly intended.

## Changelog

Follow [Keep a Changelog v1.1.0](https://keepachangelog.com/en/1.1.0/).

File: `CHANGELOG.md`. Keep the latest version at the top. Use ISO 8601 dates (`YYYY-MM-DD`).

### When to Update

Update `CHANGELOG.md` only if the repository publishes a versioned artifact.

Examples of versioned artifacts:

- Helm chart: `Chart.yaml` with `version:`
- Node package: `package.json` with a release version
- Python package: `pyproject.toml` or `setup.py`
- Other project-specific release/version files

If the repository has version files but it is unclear whether the artifact is published, ask the user.

### Changelog Sections

| Commit type                                     | Changelog section  |
|-------------------------------------------------|--------------------|
| `feat`                                          | Added              |
| `fix`                                           | Fixed              |
| `perf`                                          | Changed            |
| Breaking change `!`                             | Changed or Removed |
| Deprecated behavior                             | Deprecated         |
| Security fix                                    | Security           |
| `ci, chore, build, test, style, refactor, docs` | Skip               |

Security fixes should use the `fix` commit type and be placed under Security in the changelog.

### Version Bump Rules

Determine the current version from the versioned artifact. If the current version is ambiguous, ask the user.

- Breaking change `!` → MAJOR bump: `X.0.0`
- `feat` → MINOR bump: `x.Y.0`
- `fix` or `perf` → PATCH bump: `x.y.Z`

Do not bump the version if versioning is handled by a release owner or automated release process, unless explicitly requested.

### Formatting Template

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New feature description

### Changed
- Details of changed behavior

### Fixed
- Description of the resolved bug
```

