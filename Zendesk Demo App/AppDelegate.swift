//
//  AppDelegate.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 26/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import AnswerBotProvidersSDK
import SupportSDK
import UIKit
import Unified
import ZendeskCoreSDK
import ZenMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    static var shared: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("There is no AppDelegate")
        }
        return appDelegate
    }

    // MARK: - Lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Push notifications
        registerForPushNotifications()

        // Zendesk support
        setupZendeskSupport()

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        ZenMessaging.updateToken(deviceToken)
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

// MARK: - Private methods

private extension AppDelegate {
    func registerForPushNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { allowed, _ in
            guard allowed else { return }

            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        })
    }

    func setupZendeskSupport() {
        Zendesk.initialize(appId: "8522ae2a6589c7ca17fd491229ca5f7ca0c4866c35529afb", clientId: "mobile_sdk_client_8c54403a38a122e7dcc2", zendeskUrl: "https://demob2c-pp.zendesk.com")

        Support.initialize(withZendesk: Zendesk.instance)
        if let supportInstance = Support.instance {
            AnswerBot.initialize(withZendesk: Zendesk.instance, support: supportInstance)
        }
        Unified.initializeChat()

        if UserService.shared.isLoggedIn, let token = UserService.shared.user?.email {
            let identity = Identity.createJwt(token: token)
            Zendesk.instance?.setIdentity(identity)
        } else {
            let identity = Identity.createAnonymous()
            Zendesk.instance?.setIdentity(identity)
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let userInfo = notification.request.content.userInfo

        let shouldBeDisplayed = ZenMessaging.pushNotificationsShouldBeDisplayed(userInfo)

        switch shouldBeDisplayed {
        case .messagingShouldDisplay:
            completionHandler([.banner, .sound, .badge])
        case .messagingShouldNotDisplay, .notFromMessaging:
            completionHandler([])
        @unknown default:
            break
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo

        let shouldBeDisplayed = ZenMessaging.pushNotificationsShouldBeDisplayed(userInfo)

        switch shouldBeDisplayed {
        case .messagingShouldDisplay:
            ZenMessaging.handleTap(userInfo: userInfo, completion: { _ in })
        case .messagingShouldNotDisplay, .notFromMessaging:
            break
        @unknown default:
            break
        }
    }
}
