import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apphud_push_notifications/apphud_push_notifications_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelApphudPushNotifications platform =
      MethodChannelApphudPushNotifications();
  const MethodChannel channel = MethodChannel('apphud_push_notifications');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          expect(methodCall.method, 'registerForPushNotifications');
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('registerForPushNotifications invokes method channel', () async {
    await platform.registerForPushNotifications();
  });
}
