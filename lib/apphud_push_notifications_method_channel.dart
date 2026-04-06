import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'apphud_push_notifications_platform_interface.dart';

/// An implementation of [ApphudPushNotificationsPlatform] that uses method channels.
class MethodChannelApphudPushNotifications extends ApphudPushNotificationsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('apphud_push_notifications');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
