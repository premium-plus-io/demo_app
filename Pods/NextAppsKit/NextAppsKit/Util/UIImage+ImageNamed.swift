//
//  UIImage+ImageNamed.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIImage {

    /**
    Allows for the creation of a non-optional class variable on UIImage based on the name of an image in the asset catalog.
    For example inside an UIImage extension we could add:
    `class var logo: UIImage { image(named: "logo") }`
     
     - parameter name: name of the image in the asset catalog
     - returns: a UIImage
     */
    class func image(named name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            fatalError("No image named \(name) in asset catalog")
        }

        return image
    }
}
