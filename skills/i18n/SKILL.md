---
name: i18n
description: |
  Internationalization toolkit for React applications. Discovers hardcoded strings,
  implements translations, reviews quality, and generates coverage reports.
  Triggers: "i18n audit", "find hardcoded strings", "translate app", "i18n coverage",
  "translation review", "add language support"
license: MIT
metadata:
  author: Claude Code User
  version: 1.0.0
  category: internationalization
  tags: [i18n, react, translation, localization, react-i18next]
---

# i18n - Internationalization Toolkit

Comprehensive i18n support for React applications using react-i18next.

## What This Skill Does

1. **Discover** - Finds ALL hardcoded strings needing translation
2. **Implement** - Sets up i18n infrastructure with react-i18next
3. **Translate** - Creates organized translation files
4. **Review** - Quality assurance for translations
5. **Report** - Coverage and completeness reporting
6. **Learn** - Records missed patterns for future improvement

## Arguments

$ARGUMENTS

Format: `[mode] [options]`

Modes:
- `audit` - Full discovery of hardcoded strings (default)
- `coverage` - Generate coverage report for existing translations
- `setup` - Initialize i18n in a new project
- `add-lang <code>` - Add a new language (e.g., `add-lang de`)
- `review <lang>` - Review translations for a specific language
- `learn` - Show/update learnings from missed patterns

## Pre-Discovery: Load Learnings

**CRITICAL: Before any discovery operation, load the learnings file.**

```bash
cat ~/.claude/agents/i18n-learnings.md
```

The learnings file contains patterns that were previously missed. All patterns in that file MUST be searched for during discovery.

---

## Mode: audit (Default)

Comprehensive scan for hardcoded strings.

### Step 1: Run Discovery Scripts

```bash
bash ~/.claude/skills/i18n/scripts/discover.sh [path]
```

### Step 2: Generate Report

After discovery, produce a structured report:

| Priority | File | Line | Type | String |
|----------|------|------|------|--------|
| High | form.tsx | 45 | JSX | "Save" |
| High | dialog.tsx | 12 | prop | "Confirm deletion?" |
| Medium | toast.ts | 8 | toast | "Saved successfully" |

### Step 3: Estimate Effort

- Total strings found
- Files requiring changes
- Recommended namespace organization

---

## Mode: coverage

Generate translation coverage report.

```bash
bash ~/.claude/skills/i18n/scripts/coverage.sh [locales-path]
```

---

## Mode: setup

Initialize i18n in a React project.

### Creates
- `src/i18n/config.ts` - i18n configuration
- `public/locales/en/common.json` - Base translation file
- LanguageSwitcher component
- Test mock setup

### Installs
```bash
pnpm add i18next react-i18next i18next-browser-languagedetector i18next-http-backend
```

---

## Mode: learn

When user reports missed text:

```bash
/i18n learn "The string 'Confirm' in Modal.tsx:45 was not detected"
```

### Process
1. Analyze why the pattern was missed
2. Create new search pattern
3. Update learnings file
4. Add pattern to discovery checklist

---

## Key Files

| File | Purpose |
|------|---------|
| `~/.claude/agents/i18n-specialist.md` | Full agent specification |
| `~/.claude/agents/i18n-learnings.md` | Learnings from missed patterns |
| `~/.claude/skills/i18n/scripts/discover.sh` | Discovery automation |
| `~/.claude/skills/i18n/scripts/coverage.sh` | Coverage reporting |

---

## Success Criteria

- All hardcoded strings identified
- Learnings file checked before discovery
- New missed patterns recorded immediately
- Coverage report shows expected completeness
