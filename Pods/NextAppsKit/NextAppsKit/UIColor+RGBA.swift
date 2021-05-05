//
//  UIColor+rgba.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 17/08/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import Foundation

public extension UIColor {

    /**
     Get the rgba value from UIColor
     
     - Returns: A tuple containing 4 CGFloats (red, green, blue & alpha)
     */
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
