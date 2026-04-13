---
name: new-component
description: |
  Creates new React components with TypeScript, tests, stories, and CSS Modules.
  Use when user asks to "create component", "new component", "add component",
  or "scaffold component". Includes reusability check, atomic design classification,
  and accessibility testing setup.
license: MIT
metadata:
  author: Claude Code User
  version: 1.0.0
  category: react-development
  tags: [react, typescript, storybook, testing]
---

# New Component Creator

Create production-ready React components following project conventions.

## What This Skill Does

1. Checks for existing similar components (reusability first)
2. Classifies component as atom/molecule/organism
3. Generates all required files from templates
4. Includes accessibility testing setup
5. Creates Storybook documentation

## Arguments

$ARGUMENTS

Format: `ComponentName [--category=atoms|molecules|organisms] [--dir=path]`

## Pre-Implementation: Reusability Check

**BEFORE creating any new component:**

### Step 1: Search for Similar Components

```bash
bash ${CLAUDE_PLUGIN_ROOT}/skills/new-component/scripts/check-similar.sh ComponentName
```

Also search existing components by looking for `atoms/`, `molecules/`, `organisms/`, or `components/` directories in the project's `src/`.

### Step 2: Report Findings

**If similar component exists:**
```
SIMILAR COMPONENT FOUND: [ComponentName]
Location: [path]
Similarity: [what's similar]
Difference: [what's different]

Recommendation:
- [ ] Use existing component as-is
- [ ] Extend existing component with new prop
- [ ] Create variant of existing component
- [ ] Proceed with new component (explain why)
```

**If no similar component:**
```
No existing component matches this requirement.
Proceeding with new component creation.
```

---

## Component Classification

Use `references/atomic-design.md` to determine category:

| Category | Criteria |
|----------|----------|
| **Atom** | Single indivisible UI element, <50 lines |
| **Molecule** | 2-5 atoms combined, focused purpose, 50-150 lines |
| **Organism** | Distinct page section with business logic, >150 lines |

---

## File Generation

### Required Files

Create these files using templates from `assets/`:

```
components/
  [atoms|molecules|organisms]/
    ComponentName/
      ComponentName.tsx        # From assets/component-template.tsx
      ComponentName.test.tsx   # From assets/test-template.tsx
      ComponentName.stories.tsx # From assets/stories-template.tsx
      ComponentName.module.css # From assets/module-css-template.css
      types.ts                 # From assets/types-template.ts
      index.ts                 # From assets/index-template.ts
```

### Template Variables

Replace these placeholders in templates:
- `{{ComponentName}}` - PascalCase component name
- `{{description}}` - Brief component description
- `{{category}}` - atoms/molecules/organisms (for Storybook path)

---

## Implementation Requirements

### TypeScript
- Strict types for all props
- JSDoc comments for public API
- Proper component composition

### CSS Modules
Follow patterns in `references/css-patterns.md`:
- Use data attributes for variants: `[data-variant="primary"]`
- Use semantic selectors: `[role="listitem"]`
- Single media query at `768px`
- No magic numbers

### Accessibility
- Semantic HTML elements
- ARIA labels where needed
- Keyboard navigation support
- Focus management

### Testing
- Unit tests with Vitest
- Accessibility tests with axe
- Interaction tests as needed

### Composition
- Import existing atoms instead of creating new elements
- Use existing hooks for data
- Use existing utils for logic
- Follow patterns from similar existing components

---

## Troubleshooting

### Component folder already exists

**Cause**: Attempting to create a component that already exists.

**Solution**: Check if you meant to extend the existing component, or use a different name.

### CSS Module not resolving

**Cause**: Missing type definitions or incorrect import.

**Solution**: Ensure `*.module.css` type declarations exist in the project. Import as `import styles from './Component.module.css'`.

### Tests failing on axe checks

**Cause**: Accessibility violations in the component.

**Solution**: Review the violations list and add appropriate ARIA attributes, semantic HTML, or focus management.

### Storybook not finding component

**Cause**: Incorrect path in story meta or missing export.

**Solution**: Verify the `title` path in stories matches your folder structure, and the component is exported from index.ts.

## Success Criteria

- No duplicate components created (reusability check passes)
- All 6 files generated with correct content
- Tests pass including accessibility checks
- Storybook renders without errors
- Component follows project CSS patterns
- TypeScript has no errors
