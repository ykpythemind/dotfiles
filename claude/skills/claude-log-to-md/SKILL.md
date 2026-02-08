---
name: claude-log-to-md
description: Convert Claude Code JSONL conversation logs to readable Markdown. Use when the user wants to export, view, or share a Claude Code session as markdown.
allowed-tools: Glob, Read, Bash(ruby *)
disable-model-invocation: true
---

# Claude Log to Markdown

Convert Claude Code JSONL session logs (`~/.claude/projects/*/SESSION_ID.jsonl`) to readable Markdown output on stdout.

## Usage

Run the bundled script:

```bash
ruby scripts/jsonl_to_md.rb [FILE] [OPTIONS]
```

### Arguments

- `FILE` — Path to a `.jsonl` session file. If omitted, automatically uses the most recent session.
- `--thinking` — Include thinking blocks (rendered as collapsed `<details>`).
- `--no-truncate` — Disable truncation of long content (default max: 2000 chars per block).
- `--max-len N` — Set max characters per content block (default: 2000).
- `--project PATH` — Find latest session for a specific project path.

### Examples

```bash
# Latest session
ruby scripts/jsonl_to_md.rb

# Specific session file
ruby scripts/jsonl_to_md.rb ~/.claude/projects/-Users-me-myproject/SESSION_ID.jsonl

# Include thinking, no truncation
ruby scripts/jsonl_to_md.rb --thinking --no-truncate

# Save to file
ruby scripts/jsonl_to_md.rb > session.md
```

## Output Format

- Session metadata header (session ID, timestamp, working directory)
- `## Human` / `## Assistant` headings for each turn
- Tool calls rendered as `**Tool: Name**` with JSON input in code blocks
- Tool results rendered as `**Result:**` / `**Error:**` in code blocks
- Thinking blocks in collapsible `<details>` (when `--thinking` is used)
