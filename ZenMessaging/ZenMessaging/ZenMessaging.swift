//
//  ZenMessaging.swift
//  ZenMessaging
//
//  Created by Simon Salomons on 27/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import Foundation
import ZendeskSDKMessaging

public enum ZenMessaging {

    // MARK: - Public Methods

    public static func updateToken(_ token: Data) {
        PushNotifications.updatePushNotificationToken(token)
    }

    public static func pushNotificationsShouldBeDisplayed(_ userInfo: [AnyHashable: Any]) -> PushResponsibility {
        PushNotifications.shouldBeDisplayed(userInfo)
    }

    public static func handleTap(userInfo: [AnyHashable: Any], completion: ((UIViewController?) -> Void)?) {
        PushNotifications.handleTap(userInfo, completion: completion)
    }
}
