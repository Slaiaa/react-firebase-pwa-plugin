# CSS Module Patterns

Standard patterns for CSS Modules in React components.

## Core Principles

1. **Use nested CSS** with `&` for related styles
2. **Use data attributes** for state/variants
3. **Use semantic selectors** like `[role="..."]` or `[data-component-name="..."]`
4. **Use direct child selectors** (`>`) to prevent style leakage
5. **Single media query** at `768px` for responsive behavior

## Pattern: Variants with Data Attributes

```css
.button {
  /* Base styles */
  padding: 8px 16px;
  border-radius: 4px;

  /* Variants */
  &[data-variant="primary"] {
    background: var(--color-primary);
    color: white;
  }

  &[data-variant="secondary"] {
    background: transparent;
    border: 1px solid var(--color-primary);
  }

  /* States */
  &[data-loading="true"] {
    opacity: 0.7;
    pointer-events: none;
  }

  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
}
```

**Usage in TSX**:
```tsx
<button
  className={styles.button}
  data-variant={variant}
  data-loading={isLoading}
/>
```

## Pattern: Child Elements with Semantic Selectors

```css
.card {
  display: flex;
  flex-direction: column;

  /* Named child areas */
  > [data-component-name="header"] {
    padding: 16px;
    border-bottom: 1px solid var(--color-border);
  }

  > [data-component-name="content"] {
    padding: 16px;
    flex: 1;
  }

  > [data-component-name="footer"] {
    padding: 16px;
    border-top: 1px solid var(--color-border);
  }
}
```

## Pattern: Role-Based Selectors

```css
.list {
  display: flex;
  flex-direction: column;

  > [role="listitem"] {
    padding: 12px;

    &:not(:last-child) {
      border-bottom: 1px solid var(--color-border);
    }

    [data-component-name="icon"] {
      margin-right: 8px;
    }

    [data-component-name="label"] {
      flex: 1;
    }
  }
}
```

## Pattern: Responsive Styles

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

/* Single breakpoint for mobile */
@media only screen and (max-width: 768px) {
  .container {
    grid-template-columns: 1fr;
    gap: 8px;
  }
}
```

## Anti-Patterns to Avoid

```css
/* BAD: Deep nesting */
.container .inner .item .label { }

/* GOOD: Direct child + semantic */
.container > [role="listitem"] [data-component-name="label"] { }

/* BAD: Magic numbers */
.item { margin-top: 17px; }

/* GOOD: Consistent spacing */
.item { margin-top: var(--spacing-md); }

/* BAD: Multiple breakpoints */
@media (max-width: 1200px) { }
@media (max-width: 992px) { }
@media (max-width: 768px) { }

/* GOOD: Single breakpoint */
@media only screen and (max-width: 768px) { }
```
