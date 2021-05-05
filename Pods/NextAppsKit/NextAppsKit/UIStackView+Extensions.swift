//
//  UIStackView+Extensions.swift
//  NextAppsKit
//
//  Created by Robbe Vandecasteele on 04/03/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import UIKit

public extension UIStackView {
    func removeAllArrangedSubviews() {
        for arrangedSubview in arrangedSubviews {
            removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
    }
}
