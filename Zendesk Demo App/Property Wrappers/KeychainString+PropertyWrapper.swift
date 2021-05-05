//
//  KeychainString+PropertyWrapper.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 26/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import Foundation
import KeychainSwift

private let keychain = KeychainSwift(keyPrefix: "ZendeskDemoApp")

@propertyWrapper
struct KeychainString {

    // MARK: - Properties

    let key: String

    var wrappedValue: String? {
        get {
            keychain.get(key)
        }
        set {
            if let newValue = newValue {
                keychain.set(newValue, forKey: key, withAccess: .accessibleAfterFirstUnlockThisDeviceOnly)
            } else {
                keychain.delete(key)
            }
        }
    }

    // MARK: - LifeCycle

    init(_ key: String) {
        self.key = key
    }
}
