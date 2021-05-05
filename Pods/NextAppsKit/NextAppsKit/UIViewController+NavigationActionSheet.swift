//
//  UIViewController+NavigationActionSheet.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 26/03/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import UIKit

public extension UIViewController {

    /// Show an action sheet with available navigation apps on device (Apple Maps, Google Maps and Waze).
    ///
    /// ‼️ Don't forget to add: LSApplicationQueriesSchemes to your plist for the Google and Waze URLs!
    ///
    /// - Parameters:
    ///     - title: optional title for the actionsheet.
    ///     - message: optional message for the actionsheet.
    ///     - cancelTitle: title for the cancel button.
    ///     - actionType: action for the coordinates: only show the location or navigate to the location.
    func showNavigationActionSheet(title: String? = nil, message: String? = nil, cancelTitle: String, actionType: NavigationAction) {
        NavigationApp.checkForQuerySchemesInInfoPlist()

        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        NavigationApp.availableApps.forEach { app in
            var url: URL?

            switch actionType {
                
            case .showLocation(let lat, let long):
                url = app.locationUrl(lat: lat, long: long)
                
            case .showRoute(let lat, let long):
                url = app.directionsUrl(lat: lat, long: long)
                
            }
            
            if let url = url {
                let action = UIAlertAction(title: app.name, style: .default) { _ in
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }

                actionSheet.addAction(action)
            }
        }

        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
}
