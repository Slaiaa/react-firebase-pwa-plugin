---
paths:
  - "**/*.test.ts"
  - "**/*.test.tsx"
  - "**/*.spec.ts"
---

- Use `composeStories` from `@storybook/react` to reuse stories in unit tests
- Test accessibility with `axe` in every component test
- Use `@testing-library/react` with `screen` queries -- prefer `getByRole` over `getByTestId`
- Mock Firebase services, never call real Firestore in unit tests
- Use AAA pattern: Arrange, Act, Assert -- one blank line between each section
