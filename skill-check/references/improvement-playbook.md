# Skill Check - Improvement Playbook

## Metadata and discovery
- Make `description` a loading rule, not a process summary.
- Start with `Use when...`.
- Include negative boundaries: `Do not use for...`.
- Remove host-specific frontmatter fields unless the current runtime needs them.

## Boundary repair
Use explicit handoffs:
- “Use `skill-creator` for brand-new skill authoring.”
- “Use this skill for existing skill review and iteration.”

When two skills overlap:
1. Identify the more specific skill.
2. Narrow the broader skill’s description.
3. Add a tie-breaker sentence to both, if both are editable.

## Main file slimming
Keep in `SKILL.md`:
- Purpose and role.
- Supported modes.
- Hard rules.
- High-level workflow.
- Completion contract.

Move to `references/`:
- Long rubrics.
- Templates.
- Examples.
- Exhaustive anti-pattern lists.

Delete or merge:
- Duplicate checklists.
- Historical changelogs not used by the agent.
- Human installation guides.

## Validation strengthening
Add deterministic checks when possible:
- Frontmatter parse and name/description checks.
- File layout and broken-reference checks.
- Script smoke tests.
- Trigger conflict grep/audit.

If deterministic checks are not possible, define manual evidence requirements.

## Safe fix loop
1. Capture baseline.
2. Patch the smallest set of files.
3. Re-read changed files.
4. Re-run validators.
5. Report remaining risks.

Do not rewrite domain content just to make prose prettier. Skill-craft fixes skill reliability, not the target domain itself.
