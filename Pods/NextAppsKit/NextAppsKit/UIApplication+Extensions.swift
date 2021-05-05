//
//  UIApplication+Extensions.swift
//  NextAppsKit
//
//  Created by Robbe Vandecasteele on 06/11/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import UIKit

public extension UIApplication {
    static func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    static func openAppStorePage(appID: String) {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)") else { return }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    static func openURL(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
