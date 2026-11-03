# dotfiles

Claude Code user-level config, symlinked into `~/.claude/` item by item.

```
dotfiles/
├── install.sh                 # symlink each item below into ~/.claude/
└── claude/
    ├── CLAUDE.md              # global instructions (imports ~/.claude/CLAUDE.private.md)
    ├── settings.json          # permissions, sandbox, hooks, model
    └── hooks/
        └── notify.sh          # macOS desktop notification on Notification / Stop
```

```
~/.claude/
├── CLAUDE.md          -> dotfiles/claude/CLAUDE.md
├── settings.json      -> dotfiles/claude/settings.json
├── hooks              -> dotfiles/claude/hooks
└── CLAUDE.private.md     (not in this repo; create by hand)
```

## Install

```sh
git clone https://github.com/yi-yongjun/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` links each item individually rather than the whole `~/.claude/` directory,
so Claude Code's own runtime files stay untouched. Existing real files are moved to
`*.backup.<timestamp>` first, and dangling links left by files removed from this repo
are cleaned up. Re-run it any time; it is idempotent.

## What's inside

| File | Role |
|---|---|
| `claude/CLAUDE.md` | How Claude should work: think first, minimal diffs, verify before done |
| `claude/settings.json` | Allow/deny rules, OS-level Bash sandbox, hooks, default model |
| `claude/hooks/notify.sh` | Desktop notification when Claude needs attention or finishes |

Private context (who I am, per-company conventions) lives in `~/.claude/CLAUDE.private.md`,
which `CLAUDE.md` imports and `.gitignore` excludes.
