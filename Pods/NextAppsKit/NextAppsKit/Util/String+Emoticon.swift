//
//  String+Emoticon.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 14/08/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation
import UIKit

// adapted from: https://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji

extension UnicodeScalar {
	
	var isEmoji: Bool {
		
		switch value {
		case 0x1F600...0x1F64F, // Emoticons (smileys, etc.)
		0x1F300...0x1F5FF, // Misc Symbols and Pictographs
		0x1F680...0x1F6FF, // Transport and Map
		0x2600...0x26FF,   // Misc symbols
		0x2700...0x27BF,   // Dingbats
		0xFE00...0xFE0F,   // Variation Selectors
		0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
		65024...65039, // Variation selector
		8400...8447, // Combining Diacritical Marks for Symbols
		0x1d000...0x1f77f, // Contains flags?
		0x2100...0x26ff, // Contains flags?
		0x2B50: // White Medium Star
			return true
			
		default: return false
		}
	}
	
	var isZeroWidthJoiner: Bool {
		
		return value == 8205
	}
	
}

extension String {
	
	var glyphCount: Int {
		
		let richText = NSAttributedString(string: self)
		let line = CTLineCreateWithAttributedString(richText)
		return CTLineGetGlyphCount(line)
	}
	
	var isSingleEmoji: Bool {
		return glyphCount == 1 && containsEmoji
	}
	
	public var containsEmoji: Bool {
		
		return unicodeScalars.contains { $0.isEmoji }
	}
	
	public var containsOnlyEmoji: Bool {
		
		guard !isEmpty else {
			return true
		}
		
		return !unicodeScalars.contains(where: {
				!$0.isEmoji && !$0.isZeroWidthJoiner
			})
	}
	
	public func onlyContainsNumberOfEmoticons(max count: Int) -> Bool {
		return glyphCount <= count && containsOnlyEmoji
	}

}
