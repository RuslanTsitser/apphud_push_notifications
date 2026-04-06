import 'apphud_push_notifications_platform_interface.dart';

class ApphudPushNotifications {
  /// iOS only. Requests notification permission and registers for remote notifications
  /// so Apphud can receive the device token (Apphud Rules / push).
  ///
  /// Call after `Apphud.start` from the main `apphud` package. Configure Push Notifications
  /// capability in Xcode.
  Future<void> registerForPushNotifications() {
    return ApphudPushNotificationsPlatform.instance
        .registerForPushNotifications();
  }
}
