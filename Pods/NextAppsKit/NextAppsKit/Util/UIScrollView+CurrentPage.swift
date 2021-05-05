//
//  UIScrollView+CurrentPage.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIScrollView {

    /// Get page based on the current horizontal content offset in scrollView.
    var currentPage: Int {
        Int(currentOffset)
    }

    /// Get center offset of current visible frame in the scrollView.
    var currentOffset: CGFloat {
        (contentOffset.x + (0.5 * frame.size.width)) / frame.width
    }
}
