//
//  String+Helpers.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 11/07/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

public extension String {
	
	var first: String {
		return String(self.prefix(1))
	}
	
	var last: String {
		return String(self.suffix(1))
	}
	
	func uppercasedFirst() -> String {
		return first.uppercased() + String(self.dropFirst())
	}
	
	var initials: String {
		
		var temp = ""

		self.components(separatedBy: " ").forEach {
			temp.append($0.first)
		}
		
		return temp
	}

    var capitalizedFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }
}
