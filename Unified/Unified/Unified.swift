//
//  Unified.swift
//  Unified
//
//  Created by Jara De Prest on 28/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import ChatProvidersSDK
import Foundation

private var userToken: String?
private var authError: Error?
var kIsVisible: String { "kIsVisible" }

public enum Unified {

    // MARK: - Public Methods

    public static func initializeChat() {
        Chat.initialize(accountKey: "msvU1chUPsk7gLvO531TiaFhjk5dGNZM", appId: "8522ae2a6589c7ca17fd491229ca5f7ca0c4866c35529afb")
    }

    public static func shareAuthInfo(token: String?, error: Error?) {
        userToken = token
        authError = error

        NotificationCenter.default.post(name: .userUpdated, object: nil)
    }

    public static func logout() {
        Chat.instance?.resetIdentity { }
        shareAuthInfo(token: nil, error: nil)
    }

    public static func showAnswerBotEngine(_ isVisible: Bool) {
        NotificationCenter.default.post(name: .showAnswerBotEngine, object: nil, userInfo: [kIsVisible: isVisible])
    }

    public static func showChatEngine(_ isVisible: Bool) {
        NotificationCenter.default.post(name: .showChatEngine, object: nil, userInfo: [kIsVisible: isVisible])
    }

    public static func showSupportEngine(_ isVisible: Bool) {
        NotificationCenter.default.post(name: .showSupportEngine, object: nil, userInfo: [kIsVisible: isVisible])
    }

    // MARK: - Internal methods

    internal static func getAuthInfo() -> (token: String?, error: Error?) {
        (token: userToken, error: authError)
    }
}
