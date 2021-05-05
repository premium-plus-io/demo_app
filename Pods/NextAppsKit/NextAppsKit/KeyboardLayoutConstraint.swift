//
//  KeyboardLayoutConstraint.swift
//  NextAppsKit
//
//  Created by Jara De Prest on 21/10/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import UIKit

private var lastNotification: Notification?

@available(tvOS, unavailable)
public class KeyboardLayoutConstraint: NSLayoutConstraint {

    // MARK: - Properties

    private var offset: CGFloat = 0
    private var keyboardVisibleHeight: CGFloat = 0

    // MARK: - Lifecycle

    public override func awakeFromNib() {
        super.awakeFromNib()

        offset = constant

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        // We have to do this in main.async because if we don't,
        // superview frame is not correct yet when we calculate the superview.frame.intersection
        DispatchQueue.main.async {
            if let lastNotification = lastNotification {
                self.keyboardWillChangeNotification(notification: lastNotification)
            }
        }
    }

    // MARK: Notification

    @objc
    private func keyboardWillChangeNotification(notification: Notification) {
        lastNotification = notification

        let firstItem = self.firstItem as? UIView
        let secondItem = self.secondItem as? UIView

        let view = firstItem ?? secondItem

        guard let superview = view?.superview else {
            return
        }

        guard let userInfo = notification.userInfo else {
            return
        }

        if let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = frameValue.cgRectValue
            keyboardVisibleHeight = superview.frame.intersection(frame).height
        }

        self.updateConstant()
        switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
        case let (.some(duration), .some(curve)):

            let options = UIView.AnimationOptions(rawValue: UInt(curve.uintValue << 16))

            UIView.animate(
                withDuration: TimeInterval(duration.doubleValue),
                delay: 0,
                options: options,
                animations: {
                    superview.layoutIfNeeded()
                    return
                }, completion: { _ in }
            )
        default:
            break
        }
    }

    // MARK: - Methods

    private func updateConstant() {
        var safeAreaBottom: CGFloat = 0
        safeAreaBottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        self.constant = max(offset, keyboardVisibleHeight - safeAreaBottom)
    }
}
