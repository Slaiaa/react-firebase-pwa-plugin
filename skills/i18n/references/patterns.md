# i18n Search Patterns Reference

Quick reference for all search patterns used in i18n discovery.

## Core Patterns

### JSX Text Content
```bash
# Text between JSX tags
grep -rn ">[A-Za-z][^<]*<" --include="*.tsx"

# Multi-word text
grep -rn ">\s*[A-Z][a-z]+\s+[a-z]" --include="*.tsx"
```

### Attributes
```bash
# Title
grep -rn 'title="[A-Za-z]' --include="*.tsx"

# Placeholder
grep -rn 'placeholder="[A-Za-z]' --include="*.tsx"

# aria-label
grep -rn 'aria-label="[A-Za-z]' --include="*.tsx"

# alt text
grep -rn 'alt="[A-Za-z]' --include="*.tsx"
```

### Component Props
```bash
# Label props
grep -rn 'label="[A-Za-z]' --include="*.tsx"

# Message/description props
grep -rn '\(message\|description\)="[A-Za-z]' --include="*.tsx"

# Dialog/modal props
grep -rn '\(title\|confirmText\|cancelText\)="[A-Za-z]' --include="*.tsx"
```

### Toast/Notifications
```bash
# Toast calls
grep -rn "toast\.\(success\|error\|warning\|info\)(" --include="*.tsx"

# Generic toast
grep -rn "toast(" --include="*.tsx" -A 2
```

### Form Validation
```bash
# Zod messages
grep -rn "\.message(" --include="*.ts"

# Message properties
grep -rn "message:\s*['\"]" --include="*.ts"
```

### Tables/Lists
```bash
# Column headers
grep -rn "header:\s*['\"][A-Za-z]" --include="*.tsx"

# Table headers
grep -rn "<th[^>]*>[A-Za-z]" --include="*.tsx"
```

### States
```bash
# Empty states
grep -rn "No \(data\|items\|results\)" --include="*.tsx"

# Loading states
grep -rn "Loading" --include="*.tsx"

# Error patterns
grep -rn "Error:\|Failed\|Unable to" --include="*.tsx"
```

### Buttons/Links
```bash
# Button text
grep -rn "<Button[^>]*>[A-Za-z]" --include="*.tsx"

# Link text
grep -rn "<Link[^>]*>[A-Za-z]" --include="*.tsx"
```

## Advanced Patterns

### Template Literals
```bash
grep -rn '`[^`]*[A-Za-z]{3,}[^`]*`' --include="*.tsx"
```

### Fallback Values
```bash
# Nullish coalescing
grep -rn "\?\?\s*['\"]" --include="*.tsx"

# OR fallback
grep -rn "\|\|\s*['\"]" --include="*.tsx"
```

### Status/Badge Text
```bash
grep -rn "Active\|Inactive\|Pending\|Completed" --include="*.tsx"
```

## Verification Patterns

### Find already-translated
```bash
# Files using useTranslation
grep -rn "useTranslation" --include="*.tsx" -l

# t() calls
grep -rn "t(['\"]" --include="*.tsx"
```

### Find remaining hardcoded after implementation
```bash
# Strings not using t()
grep -rn ">[A-Z][a-z]" --include="*.tsx" | grep -v "t(" | grep -v "import\|export"
```

## One-Liner Full Scan

```bash
# Run all core patterns at once
grep -rn ">[A-Z][a-z]\|title=\"[A-Z]\|placeholder=\"[A-Z]\|aria-label=\"[A-Z]\|label=\"[A-Z]\|alt=\"[A-Z]" --include="*.tsx" src/
```
