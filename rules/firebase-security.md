---
paths:
  - "firebase/**"
  - "firestore.rules"
  - "storage.rules"
---

- Never deploy `allow read, write: if true` to production
- Always validate document structure on create/update rules
- Use `request.auth.uid` for ownership checks, never trust client-provided userId
- Test rules with emulator before deploying: `firebase emulators:exec "npm test"`
- Check both `get()` result and `exists()` before using cross-document data
