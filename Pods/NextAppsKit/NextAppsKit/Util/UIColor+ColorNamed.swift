//
//  UIColor+ColorNamed.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIColor {

    /**
    Allows for the creation of a non-optional class variable on UIColor based on the name of a color in the asset catalog.
    For example inside an UIColor extension we could add:
    `class var darkBlue: UIColor { color(named: "DarkBlue") }`
     
     - parameter name: name of color in the asset catalog
     - returns: a UIColor
     */
    @available(iOS 11.0, tvOS 11.0, *)
    class func color(named name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            fatalError("No color named \(name) in asset catalog")
        }
        return color
    }
}
