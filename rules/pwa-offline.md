---
paths:
  - "src/sw.*"
  - "src/service-worker.*"
  - "**/sw.js"
  - "**/workbox*"
---

- Precache budget: under 500KB total for app shell
- Audio/media files: always lazy-load and runtime-cache, never precache
- Version all cache names -- stale caches break offline users
- Test service worker changes in Chrome DevTools Application tab before deploying
- iOS Safari has no background sync -- always provide manual refresh fallback
