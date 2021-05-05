//
//  Date+Formatting.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 22/06/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

public extension Date {
	
	var utc: String {
		return Date.utcDateFormatter.string(from: self)
	}
	
	static var utcDateFormatter: DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.locale = Locale(identifier: "POSIX")
		return dateFormatter
	}
	
}

public extension TimeZone {
	
	static var utc: TimeZone {
		return TimeZone(abbreviation: "UTC")!
	}
	
}
