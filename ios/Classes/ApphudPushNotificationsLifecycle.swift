import UIKit
import UserNotifications
import ApphudSDK

private func isFlutterLocalNotificationsPayload(_ userInfo: [AnyHashable: Any]) -> Bool {
    // Удалённый APNs-пейлоуд flutter_local_notifications: completionHandler вызывает только FLN.
    userInfo["NotificationId"] != nil
        && userInfo["presentAlert"] != nil
        && userInfo["presentSound"] != nil
        && userInfo["presentBadge"] != nil
        && userInfo["payload"] != nil
}

extension ApphudPushNotificationsPlugin {
    static func registerForPushNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

extension ApphudPushNotificationsPlugin {
    public func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Apphud.submitPushNotificationsToken(token: deviceToken, callback: nil)
    }

    @objc(userNotificationCenter:willPresentNotification:withCompletionHandler:)
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        if isFlutterLocalNotificationsPayload(userInfo) {
            return
        }

        // completionHandler нужно вызвать до возврата из метода; отложенный Task даёт пустой пресент.
        let isHandled: Bool = {
            if Thread.isMainThread {
                return MainActor.assumeIsolated {
                    Apphud.handlePushNotification(apsInfo: userInfo)
                }
            }
            var result = false
            DispatchQueue.main.sync {
                result = MainActor.assumeIsolated {
                    Apphud.handlePushNotification(apsInfo: userInfo)
                }
            }
            return result
        }()

        if isHandled {
            completionHandler([])
            return
        }
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .list, .sound])
        } else {
            completionHandler([.alert, .sound, .badge])
        }
    }
}
