import 'package:flutter_test/flutter_test.dart';
import 'package:apphud_push_notifications/apphud_push_notifications.dart';
import 'package:apphud_push_notifications/apphud_push_notifications_platform_interface.dart';
import 'package:apphud_push_notifications/apphud_push_notifications_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockApphudPushNotificationsPlatform
    with MockPlatformInterfaceMixin
    implements ApphudPushNotificationsPlatform {
  @override
  Future<void> registerForPushNotifications() => Future.value();

  @override
  Future<String?> getApnsToken() => Future.value('token');
}

void main() {
  final ApphudPushNotificationsPlatform initialPlatform =
      ApphudPushNotificationsPlatform.instance;

  test('$MethodChannelApphudPushNotifications is the default instance', () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelApphudPushNotifications>(),
    );
  });

  test('registerForPushNotifications forwards to platform', () async {
    final plugin = ApphudPushNotifications();
    final fakePlatform = MockApphudPushNotificationsPlatform();
    ApphudPushNotificationsPlatform.instance = fakePlatform;

    await plugin.registerForPushNotifications();
  });

  test('getApnsToken forwards to platform', () async {
    final plugin = ApphudPushNotifications();
    final fakePlatform = MockApphudPushNotificationsPlatform();
    ApphudPushNotificationsPlatform.instance = fakePlatform;

    final token = await plugin.getApnsToken();
    expect(token, 'token');
  });
}
