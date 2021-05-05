//
//  UIView+Border.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIView {

    // MARK: - Properties

    /// @IBInspectable width for border
    @IBInspectable var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// @IBInspectable color for border
    @IBInspectable var borderColor: UIColor? {
        get {
            layer.borderColor.map({ UIColor(cgColor: $0) })
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    // MARK: - Methods

    /**
     Set border for the view, with an option to add rounded corners.

     - Parameters:
        - width: width of the border.
        - color: color of the border
        - cornerRadius: optional radius for the corners. Default no rounding.
        - maskedCorners: optional mask for corners. Default all corners are rounded
     */
    func setBorder(withWidth width: CGFloat, color: UIColor, cornerRadius: CGFloat = 0.0, maskedCorners: CACornerMask? = nil) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor

        if cornerRadius > 0 {
            setCornerRadius(cornerRadius, maskedCorners: maskedCorners)
        }
    }
}
