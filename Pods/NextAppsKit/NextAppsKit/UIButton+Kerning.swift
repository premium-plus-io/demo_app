//
//  UIButton+Kerning.swift
//  NextAppsKit
//
//  Created by Simon Salomons on 27/10/2020.
//

import UIKit

public extension UIButton {
    @IBInspectable var kerning: CGFloat {
        get {
            titleLabel?.kerning ?? 0
        }
        set {
            titleLabel?.kerning = newValue
            invalidateIntrinsicContentSize()
        }
    }
}

extension UIButton {
    //swiftlint:disable:next override_in_extension
    override open var intrinsicContentSize: CGSize {
        var width = titleLabel?.intrinsicContentSize.width ?? 0
        width += contentEdgeInsets.left
        width += contentEdgeInsets.right
        width += titleEdgeInsets.left
        width += titleEdgeInsets.right
        if let image = image(for: state) {
            width += image.size.width
            width += imageEdgeInsets.left
            width += imageEdgeInsets.right
        }

        return CGSize(width: width, height: super.intrinsicContentSize.height)
    }
}
