## 0.0.2

- Added `getApnsToken()` API to fetch latest APNs token from iOS side.
- Updated iOS plugin plumbing for token caching and retrieval.

## 0.0.1

- Initial iOS plugin release.
- Added `registerForPushNotifications()` API.
- Added APNs permission request and remote notifications registration flow.
- Added device token submission to Apphud via `Apphud.submitPushNotificationsToken`.
- Added foreground push presentation handling with `UNUserNotificationCenterDelegate`.
