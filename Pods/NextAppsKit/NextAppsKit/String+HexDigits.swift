//
//  String+HexDigits.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 18/08/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import Foundation

public extension String {

    /**
     - Returns: boolean indicating whether the String contains only valid hexagonal digits (excluding #)
     */
    var isHexNumber: Bool {
        guard !isEmpty else { return false }
        return filter(\.isHexDigit).count == count
    }
}
