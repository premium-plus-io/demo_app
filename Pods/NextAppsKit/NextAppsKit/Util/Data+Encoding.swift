//
//  Data+Encoding.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 22/06/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

public extension Data {
	
	var utf8String: String? {
		return string(as: .utf8)
	}
	
	func string(as encoding: String.Encoding) -> String? {
		return String(data: self, encoding: encoding)
	}
	
	var hexString: String {
		return map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
	}
	
}
