---
name: manage-dotfiles
description: >
  Modify Lonnie's chezmoi-managed dotfiles safely. Edits the correct source
  template in the dotfiles repo (~/Developer/Source.dev/dotfiles), then renders
  it to the live home-dir file with a TARGET-SCOPED `chezmoi apply` that always
  passes `--source <repo>` (the repo is at a non-standard location). Handles
  aliases (dot_zsh_aliases.tmpl → ~/.zsh_aliases) and shell config
  (dot_zshrc.tmpl → ~/.zshrc), guesses the right template + work/personal/server
  conditional for anything else and asks to confirm, never touches unrelated
  files (e.g. karabiner), and never commits without explicit permission (it
  offers a message and asks). Use when Lonnie says "add an alias", "remove an
  alias", "/manage-dotfiles", "update my dotfiles", "add this to my zshrc",
  "put this in my aliases", or asks to change/regenerate any chezmoi-managed
  config. Do NOT use for arbitrary repo edits unrelated to dotfiles.
---

# manage-dotfiles

Edit a chezmoi source template in `~/Developer/Source.dev/dotfiles`, then render
just the affected file to the home directory — without disturbing anything else.

## When to use

Fire when Lonnie wants to change something managed by his dotfiles: add/remove a
shell alias, tweak `.zshrc`, adjust git config, the Brewfile, karabiner, etc.
Also fire when he pastes a snippet and says "put this in my dotfiles / zshrc /
aliases".

Do **not** use this for ordinary edits to unrelated repos, or for changes to the
live `~/.zshrc` / `~/.zsh_aliases` directly — those are generated files and
edits there get blown away on the next `chezmoi apply`. Always go through the
source template.

## Critical invariants

- **Repo lives at a non-standard location.** chezmoi's default source is
  `~/.local/share/chezmoi`, but Lonnie's repo is `~/Developer/Source.dev/dotfiles`.
  **Every** `chezmoi` command MUST include
  `--source ~/Developer/Source.dev/dotfiles`. No exceptions.
- **Never edit the generated files** (`~/.zshrc`, `~/.zsh_aliases`, …). Edit the
  source `*.tmpl` in the repo, then apply.
- **Never commit without explicit permission.** Offer a commit message and ask.
- **Scope every apply to the target you changed** so unrelated drift (karabiner
  especially — the app rewrites its own config) is never overwritten.

## Source → target map

chezmoi naming: `dot_` prefix → leading `.` in the home dir; `.tmpl` suffix →
templated, stripped from the target name.

| Source template (in repo)              | Renders to                          |
| --------------------------------------- | ----------------------------------- |
| `dot_zsh_aliases.tmpl`                  | `~/.zsh_aliases`                    |
| `dot_zshrc.tmpl`                        | `~/.zshrc`                          |
| `dot_gitconfig.tmpl`                    | `~/.gitconfig`                      |
| `dot_Brewfile.tmpl`                     | `~/.Brewfile`                       |
| `dot_config/karabiner/karabiner.json.tmpl` | `~/.config/karabiner/karabiner.json` |
| `dot_zprofile` (not templated)          | `~/.zprofile`                       |
| `dot_p10k.zsh` (not templated)          | `~/.p10k.zsh`                       |

> Note: **aliases live in `~/.zsh_aliases`, not `~/.zshrc`.** `dot_zshrc.tmpl`
> sources `~/.zsh_aliases` at the bottom. When Lonnie says "add an alias to my
> zshrc," he almost always means the aliases file — confirm if ambiguous.

## Conditional inclusion (work / personal / server)

The repo defines two template data booleans (`.chezmoi.toml.tmpl`, set via
`promptBoolOnce` at init):

- `.work` — true on work machines, false on personal machines.
- `.server` — true when the machine acts as a server.

This machine (as of writing) is `work = true`, `server = false`. Confirm with
`chezmoi data --source ~/Developer/Source.dev/dotfiles` if unsure.

Syntax already used in the templates — match it exactly:

```gotmpl
{{ if .work }}
alias fios="cd ~/Developer/Fetch.dev/ios-fetch-rewards"
{{ else }}
alias csh="cd ~/Developer/CSH.dev/"
{{ end -}}
```

- **Work-only:** put it inside `{{ if .work }} … {{ end }}`.
- **Personal-only:** put it in the `{{ else }}` half of a work block, or a
  standalone `{{ if not .work }} … {{ end }}`.
- **Server / non-server:** `{{ if .server }}` / `{{ if not .server }}`.
- **All machines:** just add it in the unconditional top section (before the
  first `{{ if }}`).

Use the closing `{{ end -}}` (with the trailing dash) at the end of a file to
trim the trailing newline, matching the existing style. Keep aliases inside the
existing labeled ASCII-art sections (SHARED / WORK / PERSONAL) where they fit.

## Steps

1. **Classify the request.**
   - Alias add/remove → `dot_zsh_aliases.tmpl` (target `~/.zsh_aliases`).
   - `.zshrc` change → `dot_zshrc.tmpl` (target `~/.zshrc`).
   - Anything else → **best-guess** the template from the map above (e.g. git
     setting → `dot_gitconfig.tmpl`, a brew package → `dot_Brewfile.tmpl`,
     karabiner → the karabiner template) and **ask Lonnie to confirm** the file
     before editing.

2. **Guess the machine scope** (all / work-only / personal-only / server) from
   context and the existing section the content belongs in. State the guess and
   give Lonnie an easy way to override (e.g. "I'll put this in the WORK section
   — say the word if it should be shared or personal-only").

3. **Check for a dirty working copy first.**
   ```
   git -C ~/Developer/Source.dev/dotfiles status --short
   ```
   If there are **unrelated** uncommitted changes already present, STOP, show
   them, and ask how to proceed. Wait for instructions — do not bundle your
   change in with them silently.

4. **Edit the source template** in `~/Developer/Source.dev/dotfiles`. For
   removals, delete the matching line (and any now-empty conditional block).

5. **Preview, then apply — scoped to the one target.** Diff first:
   ```
   chezmoi diff --source ~/Developer/Source.dev/dotfiles ~/.zsh_aliases
   ```
   Then apply just that target:
   ```
   chezmoi apply --source ~/Developer/Source.dev/dotfiles ~/.zsh_aliases
   ```
   Naming the target path is what keeps unrelated files (karabiner, etc.) from
   being touched. **If** you ever must run a broad apply and chezmoi reports a
   conflict on an unrelated file (e.g. karabiner drift), **default to skipping
   it** — never overwrite unrelated config.

6. **Verify** the generated file:
   ```
   grep -n "<the alias/line>" ~/.zsh_aliases
   ```
   For aliases, remind Lonnie they take effect in new shells (or `source
   ~/.zsh_aliases`, or run `aa`).

7. **Offer to commit — do not commit unprompted.** Show `git -C … status
   --short`, propose a commit message, and ask whether to commit **and push**.
   Only run the commit/push after an explicit yes.

## Notes

- All chezmoi commands: `--source ~/Developer/Source.dev/dotfiles`, always.
- `.chezmoiignore` ignores `*.md`, so README/CLAUDE changes aren't applied to
  home — that's expected.
- There's a handy `aa` function in the aliases file that opens `~/.zsh_aliases`
  in `$EDITOR` and re-sources it — mention it when relevant.
- If Lonnie asks about chezmoi behavior you're unsure of, consult
  https://www.chezmoi.io/reference/ rather than guessing.
- Suggested commit message shape: `aliases: add <name>` /
  `zshrc: <what changed>` — short, imperative, scoped to the file touched.
