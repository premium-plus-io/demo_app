//
//  UICollectionView+DataUpdate.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 03/11/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {
	
	/// Make sure to call this in a `performBatchUpdates` block.
	///
	/// In order to reliable use this update mechanism, make sure every element (in
	/// oldElements and newElements) is unique. Meaning the `Equatable` conformance will not
	/// return true for 2 different elements in the `oldElements` and `newElements` arrays.
	///
	/// - Parameters:
	///   - section: The section to update.
	///   - oldElements: The elements in the collection view before the update.
	///   - newElements: The elements in the collection view after the update.
	func update<T: Equatable>(section: Int, from oldElements: [T], to newElements: [T]) {
		
		if oldElements == newElements {
			return
		}
		
		for i in 0..<max(oldElements.count, newElements.count) {
			
			let indexPath = IndexPath(item: i, section: section)
			
			let prevElement: T?
			let newElement: T?
			
			if i < oldElements.count {
				prevElement = oldElements[i]
			} else {
				prevElement = nil
			}
			
			if i < newElements.count {
				newElement = newElements[i]
			} else {
				newElement = nil
			}
			
			if let prevElement = prevElement {
				
				// if prev element still exists: move
				if let newRow = newElements.firstIndex(of: prevElement) {
					let indexPathTo = IndexPath(item: newRow, section: section)
					
					if indexPath != indexPathTo {
						self.moveItem(at: indexPath, to: indexPathTo)
					}
					
				}
				
				// if prev element does not exist in new: delete
				if !newElements.contains(prevElement) {
					self.deleteItems(at: [indexPath])
				}
				
			}
			
			if let newElement = newElement {
				
				// if element does not exist in prev: insert
				if !oldElements.contains(newElement) {
					self.insertItems(at: [indexPath])
				}
				
			}
			
		}
		
	}
	
}
