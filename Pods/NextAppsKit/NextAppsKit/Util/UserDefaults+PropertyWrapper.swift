//
//  UserDefaults+PropertyWrapper.swift
//  PropertyWrapperTest
//
//  Created by Simon Salomons on 17/08/2020.
//

import UIKit

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

private protocol AnyArray {
    var isEmpty: Bool { get }
}

extension Array: AnyArray {}

@propertyWrapper
public struct UserDefault<T: Codable> {

    // MARK: - Properties

    private let key: String
    private let defaultValue: T
    private let notification: Notification.Name?

    public var wrappedValue: T {
        get {
            // If it can be retrieved as a raw value, return that
            if let rawValue = Foundation.UserDefaults.standard.value(forKey: key) as? T {
                return rawValue
            }

            // Otherwise, try and decode it
            guard let data = Foundation.UserDefaults.standard.value(forKey: key) as? Data else { return defaultValue }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Unable to decode value: \(error)")
                return defaultValue
            }
        }
        set {
            defer {
                if let notification = notification {
                    // Dispatch async because receivers will want to access this property immediately and you can't do that
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: notification, object: nil)
                    }
                }
            }

            // If the type is supported by userdefaults, save it as a raw value
            if newValue is String || newValue is [String] ||
                newValue is Bool || newValue is [Bool] ||
                newValue is Double || newValue is [Double] ||
                newValue is Float || newValue is [Float] ||
                newValue is Int || newValue is [Int] ||
                newValue is Date || newValue is [Date] {
                if let array = newValue as? AnyArray, array.isEmpty {
                    return Foundation.UserDefaults.standard.removeObject(forKey: key)
                } else {
                    return Foundation.UserDefaults.standard.set(newValue, forKey: key)
                }
            }
            // Otherwise, continue by encoding it and saving it as data

            // If the type is optional and the value is nil, remove it from userdefaults
            if let optional = newValue as? AnyOptional, optional.isNil {
                Foundation.UserDefaults.standard.removeObject(forKey: key)
            } else {
                let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode(newValue)
                    Foundation.UserDefaults.standard.set(data, forKey: key)
                } catch {
                    print("Unable to encode value: \(error)")
                }
            }
        }
    }

    // MARK: - Lifecycle

    /**
     Propertywrapper for non-optional UserDefaults. Requires a default value.

     - Parameters:
        - key: the key for the UserDefaults property
        - default: the default value for non-optional properties
        - notification: name of optional notification to trigger when the value of the property changes. Default: nil
     */
    public init(_ key: String, default defaultValue: T, changeNotification notification: Notification.Name? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        self.notification = notification
    }
}

// MARK: - ExpressibleByNilLiteral

public extension UserDefault where T: ExpressibleByNilLiteral {

    /**
     Propertywrapper for optional UserDefaults property. Defaults to nil

     - Parameters:
       - key: the key for the optional UserDefaults property
       - notification: name of optional notification to trigger when the value of the property changes. Default: nil
    */
    init(_ key: String, changeNotification notification: Notification.Name? = nil) {
        self.init(key, default: nil, changeNotification: notification)
    }
}
