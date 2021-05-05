//
//  UIView+CornerRadius.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIView {

    // MARK: - Properties

    /// @IBInspectable corner radius for view
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    // MARK: - Public methods

    /**
    Set rounded corners for the view.

     - Parameters:
        - cornerRadius: radius for the corners.
        - maskedCorners: which corners should be rounded. Default: all corners are rounded.
    */
    func setCornerRadius(_ cornerRadius: CGFloat, maskedCorners: CACornerMask? = nil) {
        layer.cornerRadius = cornerRadius

        if let maskedCorners = maskedCorners {
            if #available(iOS 11.0, tvOS 11.0, *) {
                layer.maskedCorners = maskedCorners
            } else {
                setMaskedCorners(cornerRadius: cornerRadius, maskedCorners: maskedCorners)
            }
        }
    }
}

// MARK: - Private methods

private extension UIView {
    /**
    Set rounded corners for the view before iOS 11.0.

     - Parameters:
        - cornerRadius: radius for the corners.
        - maskedCorners: which corners should be rounded. Default: all corners are rounded.
    */
    func setMaskedCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        var cornerMask = UIRectCorner()

        if maskedCorners.contains(.layerMinXMinYCorner) {
            cornerMask.insert(.topLeft)
        }

        if maskedCorners.contains(.layerMaxXMinYCorner) {
            cornerMask.insert(.topRight)
        }

        if maskedCorners.contains(.layerMinXMaxYCorner) {
            cornerMask.insert(.bottomLeft)
        }

        if maskedCorners.contains(.layerMaxXMaxYCorner) {
            cornerMask.insert(.bottomRight)
        }

        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath

        self.layer.mask = mask
    }
}
