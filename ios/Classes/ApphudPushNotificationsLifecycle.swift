import UIKit
import UserNotifications
import ApphudSDK

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

    public func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        // Host app may log in its own AppDelegate if needed.
    }

    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // ApphudSDK marks handlePushNotification as MainActor; delegate callbacks are not.
        Task { @MainActor in
            let isHandled = Apphud.handlePushNotification(apsInfo: notification.request.content.userInfo)
            if isHandled {
                completionHandler([])
            }
        }
    }

    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        Task { @MainActor in
            let isHandled = Apphud.handlePushNotification(apsInfo: response.notification.request.content.userInfo)
            if isHandled {
                completionHandler()
            }
        }
    }
}
