//
//  UIView+Pinning.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIView {

    /**
     Pins the view to the top, trailing, bottom and leading anchor of it's superView.
     ⚠️ This does not take into account the writing system used on the device.

     - Parameters:
            - top: distance to superView's top anchor. Default: 0
            - right: distance to superView's right anchor. Default: 0
            - bottom: distance to superView's bottom anchor. Default: 0
            - left: distance to superView's left anchor.  Default: 0
     */
    func pinToEdges(top: CGFloat = 0.0, right: CGFloat = 0.0, bottom: CGFloat = 0.0, left: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left)
        ])
    }

    /**
     This is usually the pinning to use. Pins the view to the top, trailing, bottom and leading anchor of it's superView.
     In other words we follow the directionality of the writing system used on the device.

     - Parameters:
            - top: distance to superView's top anchor. Default: 0
            - leading: distance to superView's trailing anchor. Default: 0
            - bottom: distance to superView's bottom anchor. Default: 0
            - trailing: distance to superView's leading anchor.  Default: 0
     */
    func pinToDirectionalEdges(top: CGFloat = 0.0, trailing: CGFloat = 0.0, bottom: CGFloat = 0.0, leading: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading)
        ])
    }

    /**
    Sets the size of the view.

    - Parameter size: desired size of the view
    */
    func pinSize(_ size: CGSize) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ])
    }

    /**
    Sets the size of the view proportionally to the superview.

    - Parameters:
           - heightMultiplier: proportional height in relation to the superview
           - widthMultiplier: proportional width in relation to the superview
    */
    func pinSizeProportionallyToSuperview(heightMultiplier: CGFloat, widthMultiplier: CGFloat) {
        guard let superview = superview else { return }

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: widthMultiplier),
            heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: heightMultiplier)
        ])
    }

    /**
    Pins the view to the left anchor of it's superView.

    - Parameters: constant: distance to superView's left anchor. Default: 0
    */
    func pinToLeft(constant: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
    }

    /**
    Pins the view to the leading anchor of it's superView.

    - Parameters: constant: distance to superView's leading anchor. Default: 0
    */
    func pinToLeading(constant: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
    }

    /**
    Pins the view to the top anchor of it's superView.

    - Parameters: constant: distance to superView's top anchor. Default: 0
    */
    func pinToTop(constant: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
    }

    /**
    Pins the view to the right anchor of it's superView.

    - Parameters: constant: distance to superView's right anchor. Default: 0
    */
    func pinToRight(constant: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: constant).isActive = true
    }

    /**
    Pins the view to the trailing anchor of it's superView.

    - Parameters: constant: distance to superView's trailing anchor. Default: 0
    */
    func pinToTrailing(constant: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant).isActive = true
    }

    /**
    Pins the view to the bottom anchor of it's superView.

    - Parameters: constant: distance to superView's bottom anchor. Default: 0
    */
    func pinToBottom(constant: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant).isActive = true
    }

    /**
    Pin the height for the view.

    - Parameters: height: height for view.
    */
    func pinHeight(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    /**
    Pin the width for the view.

    - Parameters: width: width for view.
    */
    func pinWidth(_ width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    /**
    Pins the view to the center horizontal anchor of it's superView.

    - Parameters:
       - xOffset: horizontal offset from center. Default: 0
    */
    func pinToCenterOfHorizontalAxis(xOffset: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: xOffset)
        ])
    }

    /**
    Pins the view to the center vertical  anchor of it's superView.

    - Parameters:
       - yOffset: vertical offset from center. Default: 0
    */
    func pinToCenterOfVerticalAxis(yOffset: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: yOffset)
        ])
    }

    /**
     Pins the view to the center anchor of it's superView.

     - Parameters:
        - xOffset: horizontal offset from center. Default: 0
        - yOffset: vertical offset from center. Default: 0
     */
    func pinToCenter(xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: xOffset),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: yOffset)
        ])
    }

    /**
     Pins the view to a certain ratio. A ratio for example could be 1:5. The ratio is 1/5 = 0.2
     The default ratio is 1 which will make it square.

     - Parameters:
        - ratio: ratio of width to height. Default: 1 (1:1)
     */
    func pinToAspectRatio(_ ratio: CGFloat = 1.0) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio)
        ])
    }
}
