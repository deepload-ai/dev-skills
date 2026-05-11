#!/usr/bin/env python3
"""Validate Skill frontmatter name and description.

Usage:
    python3 scripts/validate-metadata.py --path /path/to/skill-dir
    python3 scripts/validate-metadata.py --name skill-name --description "Use when..."

This is a lint-style helper: findings are printed, and the process exits 0 unless
arguments are invalid or SKILL.md cannot be read.
"""

from __future__ import annotations

import argparse
import os
import re
import sys


def parse_frontmatter(skill_path: str) -> tuple[str | None, str | None, str]:
    skill_md = os.path.join(skill_path, "SKILL.md")
    if not os.path.isfile(skill_md):
        print(f"ERROR: SKILL.md not found at {skill_md}", file=sys.stderr)
        sys.exit(2)

    content = open(skill_md, encoding="utf-8").read()
    if not content.startswith("---\n"):
        print("ERROR: SKILL.md missing YAML frontmatter", file=sys.stderr)
        sys.exit(2)

    end = content.find("\n---\n", 4)
    if end == -1:
        print("ERROR: SKILL.md frontmatter not closed", file=sys.stderr)
        sys.exit(2)

    fm = content[4:end]
    name = None
    desc_parts: list[str] = []
    in_desc = False

    for raw in fm.splitlines():
        line = raw.rstrip()
        if line.startswith("name:"):
            name = line.split(":", 1)[1].strip().strip('"\'')
            in_desc = False
        elif line.startswith("description:"):
            val = line.split(":", 1)[1].strip()
            in_desc = val in {"|", ">"}
            if val and val not in {"|", ">"}:
                desc_parts.append(val.strip('"\''))
        elif in_desc and (line.startswith("  ") or line.startswith("\t")):
            desc_parts.append(line.strip().strip('"\''))
        else:
            in_desc = False

    return name, " ".join(desc_parts).strip(), fm


def validate(name: str | None, description: str | None, dir_name: str | None = None, fm: str = "") -> int:
    errors: list[str] = []
    warnings: list[str] = []

    if not name:
        errors.append("NAME ERROR: missing name")
    elif not re.fullmatch(r"[a-z0-9]+(-[a-z0-9]+)*", name):
        errors.append("NAME ERROR: use kebab-case lowercase letters/numbers/hyphens")
    elif dir_name and name != dir_name:
        errors.append(f"NAME ERROR: name '{name}' does not match directory '{dir_name}'")

    if not description:
        errors.append("DESCRIPTION ERROR: missing description")
    else:
        if len(description) > 1024:
            errors.append(f"DESCRIPTION ERROR: {len(description)} chars; max 1024")
        if not description.startswith("Use when"):
            warnings.append("DESCRIPTION WARNING: should start with 'Use when' for discovery")
        if not re.search(r"Do not use|Don't use|不触发|不适用", description, re.I):
            warnings.append("DESCRIPTION WARNING: add a negative boundary such as 'Do not use for...'")
        if re.search(r"\b(step|workflow|performs|执行|流程)\b", description, re.I):
            warnings.append("DESCRIPTION WARNING: may summarize workflow; prefer trigger conditions only")

    extra_fields = []
    for line in fm.splitlines():
        if re.match(r"^[A-Za-z0-9_-]+:\s*", line):
            key = line.split(":", 1)[0]
            if key not in {"name", "description"}:
                extra_fields.append(key)
    if extra_fields:
        warnings.append(f"FRONTMATTER WARNING: extra fields present: {', '.join(extra_fields)}")

    for item in errors:
        print(item)
    for item in warnings:
        print(item, file=sys.stderr)

    summary = f"name={name!r}, description_chars={len(description or '')}"
    if errors:
        print(f"FAIL: {summary}")
    elif warnings:
        print(f"PASS WITH WARNINGS: {len(warnings)} warning(s), {summary}")
    else:
        print(f"PASS: {summary}")
    return 0


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--path")
    parser.add_argument("--name")
    parser.add_argument("--description")
    args = parser.parse_args()

    if args.path:
        name, desc, fm = parse_frontmatter(args.path)
        validate(name, desc, os.path.basename(os.path.normpath(args.path)), fm)
    elif args.name and args.description:
        validate(args.name, args.description)
    else:
        parser.error("Provide --path OR both --name and --description")


if __name__ == "__main__":
    main()
