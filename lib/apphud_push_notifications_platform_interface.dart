import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'apphud_push_notifications_method_channel.dart';

abstract class ApphudPushNotificationsPlatform extends PlatformInterface {
  /// Constructs a ApphudPushNotificationsPlatform.
  ApphudPushNotificationsPlatform() : super(token: _token);

  static final Object _token = Object();

  static ApphudPushNotificationsPlatform _instance = MethodChannelApphudPushNotifications();

  /// The default instance of [ApphudPushNotificationsPlatform] to use.
  ///
  /// Defaults to [MethodChannelApphudPushNotifications].
  static ApphudPushNotificationsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ApphudPushNotificationsPlatform] when
  /// they register themselves.
  static set instance(ApphudPushNotificationsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
