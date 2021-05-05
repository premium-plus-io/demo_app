//
//  Array+Except.swift
//  NextAppsKit
//
//  Created by Robbe Vandecasteele on 26/04/2019.
//  Copyright © 2019 Next Apps. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func except(_ element: Element) -> Array {
        return filter({ $0 != element })
    }
}

/// Join optional string
extension Array where Element == Optional<String> {
    func joined(separator: String = "") -> String {
        return compactMap({ $0 }).joined(separator: separator)
    }
}

/// Remove first
extension Array where Element: Equatable {
    mutating func removeFirst(of element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}

/// Remove all
extension Array where Element: Equatable {
    func removing(_ element: Element) -> Array<Element> {
        var copy = self
        copy.removeAll(where: { $0 == element })
        return copy
    }
}
