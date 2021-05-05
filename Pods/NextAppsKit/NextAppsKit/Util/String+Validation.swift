//
//  String+Validation.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 20/06/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

public extension String {

	var isValidEmail: Bool {
		
		guard !self.isEmpty else {
			return false
		}
		
		let entireRange = NSRange(location: 0, length: self.count)
		
		let types: NSTextCheckingResult.CheckingType = [.link]
		
		guard let detector = try? NSDataDetector(types: types.rawValue) else {
			return false
		}
		
		let matches = detector.matches(in: self, options: [], range: entireRange)
		
		// should only have a single match
		guard matches.count == 1 else {
			return false
		}
		
		guard let result = matches.first else {
			return false
		}
		
		// result should be a link
		guard result.resultType == .link else {
			return false
		}
		
		// result should be a recognized mail address
		guard result.url?.scheme == "mailto" else {
			return false
		}
		
		// match must be entire string
		guard NSEqualRanges(result.range, entireRange) else {
			return false
		}
		
		// but schould not have the mail URL scheme
		if self.hasPrefix("mailto:") {
			return false
		}
		
		// no complaints, string is valid email address
		return true
	}
	
}
