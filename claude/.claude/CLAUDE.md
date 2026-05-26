# Global preferences

## Who
Jim, at Asymm Labs. Work spans satellites, RF, simulation, and 3D viz. Mixed C++/Python on Bazel monorepos.

## Tooling
- **In Bazel repos**: use Bazel for everything (build, test, format, lint, deps). Never call `pip`, `pip-compile`, `clang-format`, or `clang-tidy` from the host.
- **Ad-hoc Python** outside a build system: prefer Astral — `uv` for envs, `ty` for type-check, `ruff` for format/lint. Skip `pip`/`black`/`mypy`.
- **Protobuf boundaries** between subsystems: keep changes proto-first.

## Comms
- Terse. The diff is the summary — don't restate what you just did.
- Exploratory questions ("what would you do about X?") → 2-3 sentence recommendation with the main tradeoff. Don't pre-implement.
- Code references in `file_path:line` form.

## Editing
- No speculative abstractions. No comments unless the WHY is non-obvious.
- Edit existing files over creating new ones; don't generate `.md` docs unless asked.
- Delete dead code outright — no `_unused` renames or `// removed` markers.

## Git
- Never commit, push, merge, or force without an explicit ask.
- Never `--no-verify` or skip hooks.
- Prefer new commits over `--amend` on shared work.

## Workflow
- I run 2-3 Claude Code panes in Wave Terminal, often against one repo. Memory and this file are shared across panes; `TaskCreate` lists are per-session — keep one pane = one logical task.
