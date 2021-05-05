//
//  Keychain.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 26/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import Auth0
import Foundation
import ZendeskCoreSDK

enum Keychain {
    @KeychainString("AccessToken") private(set) static var accessToken: String?

    static var isUserAuthenticated: Bool {
        accessToken != nil && UserService.shared.userId != nil
    }
}

// MAKR: - Internal methods

extension Keychain {
    static func setToken(_ response: Credentials) {
        self.accessToken = response.accessToken
    }

    static func setUnAuthenticated() {
        Self.accessToken = nil

        let identity = Identity.createAnonymous()
        Zendesk.instance?.setIdentity(identity)

        NotificationCenter.default.post(name: .authStateChanged, object: nil)
    }
}
