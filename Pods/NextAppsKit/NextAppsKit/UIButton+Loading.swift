//
//  UIButton+Loading.swift
//  NextAppsKit
//
//  Created by Robbe Vandecasteele on 16/12/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import UIKit

public struct ProgressButtonSettings {
    public enum Style {
        case color(UIColor)
        case activityIndicatorStyle(UIActivityIndicatorView.Style)
    }

    public enum Layout {
        /**
         Fully replaces title and image and centers the UIActivityIndicatorView.
         */
        case replaceContent
    }

    public init(style: Style, layout: Layout) {
        self.style = style
        self.layout = layout
    }

    let style: Style
    let layout: Layout
}

public extension UIButton {

    private struct Keys {
        static var originalTextColor = "originalTextColor_key"
        static var originalImage = "originalImage_key"
    }

    private var originalTextColor: UIColor? {
        get { objc_getAssociatedObject(self, &Keys.originalTextColor) as? UIColor }
        set { objc_setAssociatedObject(self, &Keys.originalTextColor, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }

    private var originalImage: UIImage? {
        get { objc_getAssociatedObject(self, &Keys.originalImage) as? UIImage }
        set { objc_setAssociatedObject(self, &Keys.originalImage, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }

    private var magicTag: Int { 53950 }

    func showLoading(settings: ProgressButtonSettings) {
        guard viewWithTag(magicTag) == nil else { return}

        if originalTextColor == nil {
            originalTextColor = titleColor(for: .normal)
        }

        if originalImage == nil {
            originalImage = image(for: .normal)
        }

        let indicator = UIActivityIndicatorView()
        indicator.tag = magicTag
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)

        switch settings.style {
        case let .color(color):
            indicator.color = color
        case let .activityIndicatorStyle(indicatoryStyle):
            indicator.style = indicatoryStyle
        }

        indicator.widthAnchor.constraint(equalToConstant: 26).isActive = true
        indicator.heightAnchor.constraint(equalTo: indicator.widthAnchor).isActive = true

        indicator.startAnimating()

        isEnabled = false

        switch settings.layout {
        case .replaceContent:
            indicator.pinToCenter()
            setImage(nil, for: .normal)
            setTitleColor(.clear, for: .normal)
        }
    }

    func hideLoading() {
        isEnabled = true
        setTitleColor(originalTextColor, for: .normal)
        setImage(originalImage, for: .normal)
        viewWithTag(magicTag)?.removeFromSuperview()
    }
}
