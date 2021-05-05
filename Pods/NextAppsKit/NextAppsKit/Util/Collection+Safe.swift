//
//  Collection+Safe.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 01/03/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

public extension Collection {
	
	/// Returns the element at the specified index iff it is within bounds, otherwise nil.
	///
	/// Please note: don't overuse this. 
	/// It is often best practice to use the "non-safe" subscript.
	subscript (safe index: Index) -> Iterator.Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
