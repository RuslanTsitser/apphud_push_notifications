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
          switch (methodCall.method) {
            case 'registerForPushNotifications':
              return null;
            case 'getApnsToken':
              return 'token';
            default:
              fail('Unexpected method: ${methodCall.method}');
          }
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('registerForPushNotifications invokes method channel', () async {
    await platform.registerForPushNotifications();
  });

  test('getApnsToken invokes method channel', () async {
    final token = await platform.getApnsToken();
    expect(token, 'token');
  });
}
