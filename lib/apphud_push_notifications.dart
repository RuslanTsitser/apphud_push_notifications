
import 'apphud_push_notifications_platform_interface.dart';

class ApphudPushNotifications {
  Future<String?> getPlatformVersion() {
    return ApphudPushNotificationsPlatform.instance.getPlatformVersion();
  }
}
