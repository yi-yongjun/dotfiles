#!/bin/bash
# PreToolUse(Bash) hook: sandbox.excludedCommands only match when the command
# starts with the excluded prefix. A `cd … &&` prefix, a pipe or a redirect makes
# it run inside the sandbox, where it fails (keychain, .env, watchman socket).
# Block those forms and tell Claude to rerun the bare command.

raw=$(/usr/bin/jq -r '.tool_input.command // empty')
[ -z "$raw" ] && exit 0

# Ignore text inside heredoc bodies and quotes (PR bodies, jq filters, -t "a|b").
cmd=$(printf '%s' "$raw" | /usr/bin/perl -0pe '
    s/<<-?\s*["\x27]?(\w+)["\x27]?([^\n]*)\n.*?\n\1(\n|$)/<<HEREDOC$2$3/sg;
    s/\x27[^\x27]*\x27/Q/g;
    s/"(?:\\.|[^"\\])*"/Q/g;
')

heads='git (push|pull|fetch|clone)|gh|ssh|yarn (workspace [^[:space:]]+ test|test(:unit)?|jest)'

# Does an excluded command appear at a command position?
if ! printf '%s' "$cmd" | grep -qE "(^|[;&|(][[:space:]]*)[[:space:]]*(${heads})([[:space:]]|$)"; then
    exit 0
fi

# Allowed: starts with the excluded command and has no chaining, pipe or redirect.
if printf '%s' "$cmd" | grep -qE "^[[:space:]]*(${heads})([[:space:]]|$)" &&
    ! printf '%s' "$cmd" | grep -qE '[|;&>]'; then
    exit 0
fi

echo "BLOCKED: sandbox-excluded command must run bare. Remove any 'cd … &&' prefix, '2>&1', pipes and chaining, and run it as a single command starting with the excluded prefix (e.g. 'yarn workspace main test <path>', 'git push origin <branch>')." >&2
exit 2
