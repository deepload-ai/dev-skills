# Skill Check - Review Framework

## Scoring rubric
Score each dimension 0/1/2:

| Score | Meaning |
|---|---|
| 2 | Clear, source-backed, and fit for purpose |
| 1 | Present but ambiguous, bloated, stale, or weakly validated |
| 0 | Missing, broken, or likely to mislead execution |

Total score: 16 points. Use score as a triage aid, not as an absolute cross-skill ranking.

## Dimensions

### 1. Discovery and trigger precision
- `description` starts with “Use when...” and describes when to load the skill, not the workflow.
- Description includes concrete triggers and negative boundaries.
- Name is kebab-case and matches directory name.

### 2. Scope and non-trigger boundaries
- Skill says what it does and what it does not do.
- Related skills are referenced as handoffs, not duplicated.
- No broad “use for all code/docs/research” phrasing.

### 3. Main workflow clarity
- Steps are ordered and executable.
- Inputs/outputs are clear.
- Safe autonomous behavior is defined.
- Checkpoints are useful evidence summaries, not permission gates.

### 4. Evidence, validation, and completion
- Claims require evidence appropriate to the task.
- Final report shape is defined.
- Validation commands or checks are included when deterministic checks are possible.
- Known gaps and unresolved items are reported, not hidden.

### 5. Context efficiency and progressive disclosure
- `SKILL.md` contains only always-needed instructions.
- Long templates/checklists live in directly referenced files under `references/`.
- No redundant README/CHANGELOG/how-we-built-it files.
- Reference files are not deeply nested and are loaded only when useful.

### 6. Reference/script integrity
- Every `references/*.md` mentioned by `SKILL.md` exists.
- Scripts run or fail with clear output.
- Scripts are optional helpers unless the workflow truly requires them.
- No stale filenames or broken paths.

### 7. Portability and host assumptions
- Avoids hard-coded `/home`, `/Users`, project-specific paths, credentials, host-only CLIs, or Claude-only tool names in generic skills.
- If a host-specific tool is required, fallback behavior is documented.
- Does not write external/global state unless requested.

### 8. Conflict risk with neighboring skills
- Related skills have clear handoff boundaries.
- Trigger descriptions do not overlap without tie-breakers.
- Audit notes identify which skill should handle ambiguous prompts.

## Severity mapping
- **P0**: invalid frontmatter, missing `SKILL.md`, broken required reference, severe route conflict, unsafe default write, or instruction that blocks autonomous completion.
- **P1**: bloated main file, weak evidence rules, unclear completion contract, stale tool names, broad trigger, duplicated responsibility.
- **P2**: wording cleanup, template polish, optional reference split, minor portability warning.

## Hard caps
- Missing or invalid `SKILL.md` frontmatter: max 4/16.
- Broken referenced file: max 8/16.
- No evidence/validation guidance for a judgment-heavy skill: max 10/16.
- Severe trigger conflict with another installed skill: max 10/16 until boundary is fixed.
