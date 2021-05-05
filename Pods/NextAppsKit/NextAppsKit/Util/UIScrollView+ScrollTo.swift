//
//  UIScrollView+ScrollTo.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIScrollView {
    /**
     Scroll to a certain page within the scrollView
     
     - Parameters:
        - page: which page to scroll to.
        - animated: animate the scroll.
     */
    func scrollTo(page: Int, animated: Bool) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0

        self.scrollRectToVisible(frame, animated: animated)
    }
}
