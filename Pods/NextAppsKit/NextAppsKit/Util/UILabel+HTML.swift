//
//  UILabel+HTML.swift
//  NextAppsKit
//
//  Created by Simon Salomons on 20/05/2019.
//

import UIKit

public enum UILabelHTMLError: Error {
    case invalidData
}

public extension UILabel {
    func setHTML(_ html: String) throws {
        guard let data = html.data(using: .unicode) else {
            throw UILabelHTMLError.invalidData
        }
        
        let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        
        // To show an ellipsis when the text is cut off...
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: range)
        
        self.attributedText = attributedString
    }
}
