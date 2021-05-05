//
//  UIView+Shadow.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIView {

    // MARK: - Properties

    /// @IBInspectable radius for shadow
    @IBInspectable var shadowRadius: CGFloat {
        get {
            layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    /// @IBInspectable opacity for shadow
    @IBInspectable var shadowOpacity: Float {
        get {
            layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// @IBInspectable offset of shadow
    @IBInspectable var shadowOffset: CGSize {
        get {
            layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// @IBInspectable color for shadow
    @IBInspectable var shadowColor: UIColor? {
        get {
            layer.shadowColor.map({ UIColor(cgColor: $0) })
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    // MARK: - Methods

    /**
     Set shadow on view.
    
     - Parameters:
        - color: the color of the shadow
        - opacity: how transparent the shadow is, where 0 is invisible and 1 is as strong as possible. Default: 1.0
        - offset: how far away from the view the shadow should be. Default: .zero
        - radius: how wide the shadow should be.  Default: 0.0
    */
    func setShadow(withColor color: UIColor, opacity: Float = 1.0, offset: CGSize = .zero, radius: CGFloat = 0.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
