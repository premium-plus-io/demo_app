//
//  UITableViewCell+Highlight.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 03/05/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
	
	public func setSelectionHighlightColor(_ color: UIColor) {
		
		let bgColorView = UIView()
		bgColorView.backgroundColor = color
		self.selectedBackgroundView = bgColorView
		
	}
	
}
