//
//  UITableView+DataUpdate.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 11/07/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
	
	var isScrolledToBottom: Bool {
		return contentOffset.y >= (contentSize.height - frame.size.height)
	}
	
	/// Make sure to call `beginUpdates()` before calling this, and `endUpdates()` after.
	///
	/// In order to reliable use this update mechanism, make sure every element (in
	/// oldElements and newElements) is unique. Meaning the `Equatable` conformance will not
	/// return true for 2 different elements in the `oldElements` and `newElements` arrays.
	///
	/// - Parameters:
	///   - section: The section to update.
	///   - oldElements: The elements in the table view before the update.
	///   - newElements: The elements in the table view after the update.
	///   - animation: Row animation to use. Default is `automatic`.
	func update<T: Equatable>(section: Int, from oldElements: [T], to newElements: [T], animation: UITableView.RowAnimation = .automatic) {
		
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
						self.moveRow(at: indexPath, to: indexPathTo)
					}
					
				}
				
				// if prev element does not exist in new: delete
				if !newElements.contains(prevElement) {
					self.deleteRows(at: [indexPath], with: animation)
				}
				
			}
			
			if let newElement = newElement {
				
				// if element does not exist in prev: insert
				if !oldElements.contains(newElement) {
					self.insertRows(at: [indexPath], with: animation)
				}
				
			}
			
		}
		
	}
	
}
