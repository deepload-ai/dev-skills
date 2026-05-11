#!/usr/bin/env python3
"""Validate a Skill directory structure and local references.

Usage:
    python3 scripts/validate-structure.py --path /path/to/skill-dir

Lint-style helper: prints findings and exits 0 unless arguments are invalid.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
from pathlib import Path

SKILL_WARN_LINES = 200
SKILL_MAX_LINES = 500
REF_MAX_LINES = 500
ALLOWED_TOP_LEVEL = {"SKILL.md", "references", "scripts", "assets", "agents", "config.json"}
UNWANTED_DOCS = {"README.md", "CHANGELOG.md", "INSTALLATION.md", "INSTALLATION_GUIDE.md", "QUICK_REFERENCE.md"}


def parse_frontmatter(content: str) -> tuple[str | None, str | None]:
    if not content.startswith("---\n"):
        return None, None
    end = content.find("\n---\n", 4)
    if end == -1:
        return None, None
    fm = content[4:end]
    name = None
    description = None
    for line in fm.splitlines():
        if line.startswith("name:"):
            name = line.split(":", 1)[1].strip().strip('"\'')
        elif line.startswith("description:"):
            val = line.split(":", 1)[1].strip()
            if val and val not in {"|", ">"}:
                description = val.strip('"\'')
    if description is None and "description:" in fm:
        desc_line = fm.split("description:", 1)[1].splitlines()[1:]
        description = " ".join(l.strip() for l in desc_line if l.startswith("  "))
    return name, description


def validate(path: Path) -> None:
    errors: list[str] = []
    warnings: list[str] = []
    info: list[str] = []

    skill_md = path / "SKILL.md"
    if not skill_md.is_file():
        print("STRUCTURE ERROR: SKILL.md not found")
        return

    content = skill_md.read_text(encoding="utf-8")
    lines = content.splitlines()
    info.append(f"SKILL.md lines: {len(lines)}")

    if len(lines) > SKILL_MAX_LINES:
        errors.append(f"BUDGET ERROR: SKILL.md has {len(lines)} lines; max {SKILL_MAX_LINES}")
    elif len(lines) > SKILL_WARN_LINES:
        warnings.append(f"BUDGET WARNING: SKILL.md has {len(lines)} lines; consider moving detail to references/")

    name, description = parse_frontmatter(content)
    if not name or not description:
        errors.append("FRONTMATTER ERROR: name and description are required")
    elif name != path.name:
        errors.append(f"FRONTMATTER ERROR: name '{name}' does not match directory '{path.name}'")

    for item in path.iterdir():
        if item.name in UNWANTED_DOCS:
            warnings.append(f"CLUTTER WARNING: {item.name} is usually unnecessary in a Skill")
        if item.name not in ALLOWED_TOP_LEVEL:
            warnings.append(f"STRUCTURE WARNING: unexpected top-level item {item.name}")

    refs_dir = path / "references"
    if refs_dir.exists():
        if not refs_dir.is_dir():
            errors.append("STRUCTURE ERROR: references exists but is not a directory")
        else:
            refs = sorted(p for p in refs_dir.iterdir() if p.is_file())
            info.append(f"reference files: {len(refs)}")
            for ref in refs:
                ref_lines = len(ref.read_text(encoding="utf-8").splitlines())
                if ref_lines == 0:
                    errors.append(f"REFERENCE ERROR: {ref.relative_to(path)} is empty")
                elif ref_lines > REF_MAX_LINES:
                    warnings.append(f"BUDGET WARNING: {ref.relative_to(path)} has {ref_lines} lines")
            for nested in refs_dir.rglob("*"):
                if nested.is_dir():
                    warnings.append(f"STRUCTURE WARNING: nested reference directory {nested.relative_to(path)}")

    mentioned = set(re.findall(r"references/([A-Za-z0-9_.-]+\.md)", content))
    existing = {p.name for p in refs_dir.glob("*.md")} if refs_dir.is_dir() else set()
    for ref in sorted(mentioned - existing):
        errors.append(f"REFERENCE ERROR: SKILL.md mentions references/{ref} but it does not exist")
    for ref in sorted(existing - mentioned):
        warnings.append(f"REFERENCE WARNING: references/{ref} is not mentioned by SKILL.md")

    scripts_dir = path / "scripts"
    if scripts_dir.exists():
        scripts = sorted(p for p in scripts_dir.iterdir() if p.is_file())
        info.append(f"script files: {len(scripts)}")

    print("=== Skill Structure Validation ===")
    for item in info:
        print(f"  {item}")
    for item in warnings:
        print(f"WARNING: {item}", file=sys.stderr)
    for item in errors:
        print(f"ERROR: {item}")

    if errors:
        print(f"FAIL: {len(errors)} error(s), {len(warnings)} warning(s)")
    elif warnings:
        print(f"PASS WITH WARNINGS: {len(warnings)} warning(s)")
    else:
        print("PASS")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--path", required=True)
    args = parser.parse_args()
    path = Path(args.path)
    if not path.is_dir():
        print(f"ERROR: Directory not found: {path}", file=sys.stderr)
        sys.exit(2)
    validate(path)


if __name__ == "__main__":
    main()
