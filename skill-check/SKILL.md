---
name: skill-check
description: Use when reviewing, auditing, repairing, or improving an existing Codex/agent Skill directory, especially when a skill mis-triggers, fails to trigger, produces inconsistent outputs, has bloated instructions, stale references, weak validation, or route conflicts with other skills. Do not use for creating a brand-new skill from scratch; use skill-creator for new-skill authoring.
---

# Skill Check — Skill Quality Review and Iteration

## Role
`skill-check` is a quality layer for **existing** skills. It complements, not replaces, the built-in `skill-creator`:

- Use `skill-creator` to design or scaffold a new skill.
- Use `skill-check` to evaluate, repair, regression-check, and iteratively improve a skill that already exists.

## Supported modes
- **check**: read-only quality review of one skill directory.
- **fix**: review then edit one skill directory to address confirmed issues.
- **audit**: compare multiple skills for routing conflicts, duplicated responsibilities, stale references, and inconsistent conventions.

Do not run create mode. If the target does not exist or the user wants a new skill, hand off to `skill-creator`.

## Hard rules
- **Evidence first**: every issue and fix must cite `file:line` or a concrete script/check result.
- **No signal-only conclusions**: symptoms such as “does not trigger” start investigation; they are not proof.
- **Protect skill boundaries**: do not broaden a skill’s trigger unless evidence shows the current trigger is too narrow.
- **Small reversible edits**: fix only confirmed skill-quality issues; avoid rewriting domain content unless it is stale, duplicated, or blocks execution.
- **Progressive disclosure**: keep `SKILL.md` lean; move detailed checklists, examples, and templates into `references/` only when they are actually useful.

## Workflow

### 1. Scope and baseline
Identify target mode and skill path.

For a single skill, collect:
- `SKILL.md` frontmatter: name, description, extra fields.
- File layout: `references/`, `scripts/`, `assets/`, `agents/` if present.
- `SKILL.md` length and referenced files.
- Any user-reported symptoms.

Run available local validators when present:
```bash
python3 skill-check/scripts/validate-metadata.py --path <skill-dir>
python3 skill-check/scripts/validate-structure.py --path <skill-dir>
```

Checkpoint: `Baseline: files F, SKILL.md L lines, metadata {pass/warn/fail}, structure {pass/warn/fail}`

### 2. Quality review
Load `references/review-framework.md` and score only with observed evidence.

Review dimensions:
1. Discovery and trigger precision.
2. Scope and non-trigger boundaries.
3. Main workflow clarity.
4. Evidence, validation, and completion contract.
5. Context efficiency and progressive disclosure.
6. Reference/script integrity.
7. Portability and host assumptions.
8. Conflict risk with neighboring skills.

Classify findings:
- **P0**: likely prevents correct loading/execution or causes wrong-skill routing.
- **P1**: likely causes inconsistent behavior, unverifiable output, or context waste.
- **P2**: maintainability or clarity improvement.

Checkpoint: `Review: P0 x, P1 y, P2 z, confidence {high/medium/low}`

### 3. Fix plan, if requested
For fix mode, load `references/improvement-playbook.md` and produce a concise patch plan before editing.

Fix order:
1. Metadata/frontmatter and trigger boundaries.
2. Broken references, missing files, invalid scripts.
3. Bloated or duplicated `SKILL.md` content.
4. Weak validation/completion contract.
5. Route conflicts and stale terminology.

Do not ask for permission for safe local edits already requested by the user. Ask only before destructive deletion of user-authored assets or externally visible writes.

Checkpoint: `Fix plan: N edits across M files; destructive edits: yes/no`

### 4. Apply and verify
After edits:
- Re-read changed files.
- Re-run validators and targeted checks.
- Confirm referenced files exist.
- Confirm trigger text still matches the skill’s intended use and does not duplicate `skill-creator` unless intentionally delegated.

Use `references/report-template.md` for final reporting.

Checkpoint: `Verify: metadata {pass/warn/fail}, structure {pass/warn/fail}, remaining P0/P1/P2`

## Audit mode
For a parent directory containing multiple skills:
- List every `*/SKILL.md`.
- Compare names, descriptions, trigger phrases, and “do not use” boundaries.
- Identify duplicated responsibilities and missing handoff language.
- Sample 3-5 likely user prompts and decide which skill should trigger.
- Recommend merges, splits, or boundary edits; edit only when explicitly in fix scope.

## Decision gate
Strong findings require:
- **Evidence**: exact file line, script output, or direct comparison.
- **Counter-check**: possible legitimate reason the pattern exists.
- **Scope**: affected skill/file/mode.
- **Decision**: confirmed / tentative / unresolved.

If counter-check is missing, mark the finding tentative. If evidence is missing, do not report it as a finding.

## Completion contract
Final response must include:
- Whether `skill-check` or `skill-creator` is the right tool for the task.
- Files changed, if any.
- Confirmed findings fixed and remaining risks.
- Validation commands/results.
- Recommended next iteration, if useful.
