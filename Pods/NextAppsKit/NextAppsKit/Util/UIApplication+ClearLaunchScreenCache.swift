//
//  UIApplication+ClearLaunchScreenCache.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 14/08/2020.
//

import UIKit

public extension UIApplication {

    /// Used to clear the lanch screen cache. For development purposes only.
    func clearLaunchScreenCache() {
        #if DEBUG
        try? FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        #endif
    }
}
