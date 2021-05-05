//
//  NotificationCenter+Util.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 24/08/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

public extension NotificationCenter {
	
	func post(_ aName: NSNotification.Name) {
		post(name: aName, object: nil)
	}
	
}
