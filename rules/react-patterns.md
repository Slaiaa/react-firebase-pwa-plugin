---
paths:
  - "src/**/*.tsx"
  - "src/**/*.ts"
---

- Use TypeScript strict mode -- no `any` types without justification
- Prefer named exports over default exports
- Use `interface` for component props, `type` for unions/intersections
- State management: TanStack Query for server state, Context/Zustand for UI state, useState for local
- Use CSS Modules with data attributes for variants, not className string concatenation
- Wrap shadcn/ui components -- never modify files in `src/components/ui/` directly
- All user-facing text must go through i18n (react-i18next `useTranslation`)
