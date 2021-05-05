//
//  Validation.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 19/06/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation
import UIKit

// MARK: - EmptyCheckable

public protocol EmptyCheckable {
	
	var isEmpty: Bool { get }
	
}

public extension EmptyCheckable {
	
	var isNotEmpty: Bool {
		return !isEmpty
	}
	
}


// MARK: - HasEditableText

public protocol HasEditableText: EmptyCheckable {
	
	var text: String? { get set }
	
}

public extension HasEditableText {
	
	var isEmpty: Bool {
		guard let text = text else {
			return true
		}
		return text.isEmpty
	}
	
	/// Returns empty string if `text` property is nil.
	var unwrappedText: String {
		return text ?? ""
	}
	
}


// MARK: - Conformance

extension Array: EmptyCheckable { }

extension String: EmptyCheckable { }

extension UITextField: HasEditableText { }

extension UILabel: HasEditableText { }

extension UISearchBar: HasEditableText { }
