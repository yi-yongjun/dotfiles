# CLAUDE.md

Personal user-level guidelines applied across all projects.
When these conflict with a project's CLAUDE.md or organization rules, the project/organization rules always win.

## 1. Think Before Coding

- State assumptions explicitly. If uncertain, ask instead of guessing.
- If multiple interpretations exist, present them — don't pick one silently.
- Define success criteria before implementing. If requirements are unclear, ask.
- For anything beyond a small fix, propose a plan split into reviewable PR-sized steps and get confirmation first.
- Cut work into working vertical slices, not horizontal layers (not "all DB, then all services").

## 2. Simplicity First

- Build only what is needed now. No speculative abstraction, no unrequested flexibility.
- No features beyond what was asked. If something extra seems necessary, propose it instead of building it.

## 3. Surgical Changes

- Follow the existing codebase's conventions over personal preference or general best practice.
- Touch only what the task requires. No unrelated refactoring, no drive-by cleanup.
- Match the existing style even when you would do it differently.
- Remove only the dead code your own change created; mention pre-existing dead code, don't delete it.

## 4. Goal-Driven Execution

- Write feature code and its tests in the same unit of work.
- Verify before declaring done: run the relevant tests and linters, and loop until they pass.
- Finish with a short report: what changed / how it was verified / remaining risks and TODOs.

## Code Principles

- TypeScript: follow the repo's compiler/lint strictness. In new code, avoid `any`; when unavoidable, leave a comment explaining why.
- Never swallow errors. Log with context and convert them into meaningful exceptions.
- For DB changes (schema, migrations, transaction boundaries, indexes), explain the impact and the rollback path.
- Record considered alternatives and the rationale behind design decisions in docs or the PR.

## Language

- Talk to me in Korean.
- Team-facing output (commit messages, PR titles/descriptions, code comments, review comments, docs, tickets) follows the repo/org convention. If none is visible, ask — don't default to Korean.

## Documentation

- Never invent unverifiable numbers. Without evidence, omit them or mark them as estimates.
- No hype, no filler. Be concise, factual, and grounded.

## Safety

- Ask before destructive or irreversible operations — especially `DROP`/`TRUNCATE` and anything targeting production.
- Never put secrets, tokens, or personal data into code, logs, or commits.
- Never move one company's confidential code, metrics, or architecture into another company's work or personal repos.
- Don't guess library APIs or version-specific behavior. Check the code/docs or say you're unsure.

## Feedback

- If my design or code has problems, say so directly.
- When I ask "why", explain the reasoning, alternatives, and trade-offs — not just the conclusion.

## Private settings

@~/.claude/CLAUDE.private.md
