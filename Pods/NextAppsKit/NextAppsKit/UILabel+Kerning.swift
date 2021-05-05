//
//  UILabel+Extensions.swift
//  NextAppsKit
//
//  Created by Simon Salomons on 27/10/2020.
//

import UIKit

public extension UILabel {
    @IBInspectable var kerning: CGFloat {
        get {
            // Can't read kerning if text is empty
            var wasEmpty = false
            if text?.isEmpty ?? true {
                wasEmpty = true
                text = " "
            }
            // Read kerning
            let kerning = (attributedText?.attribute(.kern, at: 0, effectiveRange: nil) as? CGFloat) ?? 0
            // Put back empty text if it was empty
            if wasEmpty {
                self.text = ""
            }
            return kerning
        }
        set {
            if #available(iOS 13, *) {} else {
                // Remove any observers attached to this label. We will add it again afterwards. This prevents an infinite loop
                if let index = textObservers.firstIndex(where: { $0.label == self }) {
                    textObservers[index].observation.invalidate()
                    textObservers.remove(at: index)
                }
            }

            // Can't set kerning if text is empty
            var wasEmpty = false
            if text?.isEmpty ?? true {
                wasEmpty = true
                text = " "
            }
            // Set kerning
            let text = attributedText ?? NSAttributedString()
            let attributedString = NSMutableAttributedString(attributedString: text)
            attributedString.addAttribute(.kern, value: newValue, range: NSRange(location: 0, length: text.string.count))
            attributedText = attributedString
            // Put back empty text if it was empty
            if wasEmpty {
                self.text = ""
            }

            if #available(iOS 13, *) {} else {
                // Observe the text property to reset the kerning since iOS 11 & 12 throw away the attributes when changing the text.
                // The observations are stored in memory, and are only released if text on another label is set.
                // Each observation takes up about 16 bytes of memory until its label doesn't exist anymore and this setter gets called again. It's a small price to pay for convenience and luckily no longer necessary from iOS 13 and up
                let observation = observe(\.text) { [weak self] _, _ in
                    self?.kerning = newValue
                }
                let wrapper = ObservationWrapper(label: self, observation: observation)
                textObservers.append(wrapper)

                textObservers.removeAll(where: { $0.label == nil })
            }
        }
    }

    func setKerning(_ kerning: CGFloat) {
        self.kerning = kerning
    }
}

private struct ObservationWrapper {
    weak var label: UILabel?
    let observation: NSKeyValueObservation
}

private var textObservers: [ObservationWrapper] = []
