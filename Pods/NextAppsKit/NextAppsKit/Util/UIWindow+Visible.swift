//
//  UIWindow+Visible.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 17/07/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation
import UIKit

public extension UIWindow {
	
	@objc var visibleViewController: UIViewController? {
		
		var topController = self.rootViewController
		
		while topController?.presentedViewController != nil {
			topController = topController?.presentedViewController
		}
		
		if topController is UINavigationController {
			let visible = (topController as? UINavigationController)?.visibleViewController
			if visible != nil {
				topController = visible
			}
		}
		
		// TODO: support tab bar controller?
		
		return topController
		
	}
	
}
