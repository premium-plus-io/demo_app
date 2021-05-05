//
//  NavigationApp.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 26/03/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import UIKit

/// The action after tapping one of the navigation apps.
public enum NavigationAction {
    /// Only show the location on the map.
    /// - lat: latitutude of the desired location.
    /// - long: longitude of the desired location.
    case showLocation(lat: Double, long: Double)
    /// Show and prepare a route from "here" to the location.
    /// - lat: latitude of the destination.
    /// - long: longitude of the destination.
    case showRoute(lat: Double, long: Double)
}

/// The supported apps to use for navigation. Depends on which app is installed on the user's device.
internal enum NavigationApp: String, CaseIterable {
    /// Use Apple Maps, available on any device.
    case appleMaps = "maps"
    /// Use Google Maps if available on the device.
    case googleMaps = "comgooglemaps"
    /// Use Waze, if available on the device.
    case waze = "waze"

    // MARK: - Static properties

    internal static var availableApps = NavigationApp.allCases.filter({ $0.isAvailable })

    // MARK: - Properties

    private var url: URL? {
         URL(string: self.urlString)
    }

    private var urlString: String {
        return "\(rawValue)://"
    }

    internal var isAvailable: Bool {
        guard let url = self.url else {
            return false
        }

        return UIApplication.shared.canOpenURL(url)
    }

    internal var name: String {
        switch self {

        case .appleMaps:
            return "maps_navigation_app".localized()

        case .googleMaps:
            return "google_maps_navigation_app".localized()

        case .waze:
            return "waze_navigation_app".localized()
        }
    }
}

// MARK: - Internal methods

internal extension NavigationApp {
    
    func locationUrl(lat: Double, long: Double) -> URL? {
        var urlString = self.urlString

        switch self {

        case .appleMaps:
            urlString.append("?q=\(lat),\(long)")

        case .googleMaps:
            urlString.append("?center=\(lat),\(long)")

        case .waze:
            urlString.append("?ll=\(lat),\(long)")
        }

        let urlStringWithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString

        return URL(string: urlStringWithPercentEscapes)
    }

    func directionsUrl(lat: Double, long: Double) -> URL? {
        var urlString = self.urlString

        switch self {

        case .appleMaps:
            urlString.append("?q=\(lat),\(long)&dirflg=d&t=m")

        case .googleMaps:
            urlString.append("?saddr=&daddr=\(lat),\(long)&directionsmode=driving")

        case .waze:
            urlString.append("?ll=\(lat),\(long)&navigate=yes")
        }

        let urlStringWithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString

        return URL(string: urlStringWithPercentEscapes)
    }

    static func checkForQuerySchemesInInfoPlist() {
        guard let plistURL = Bundle.main.url(forResource: "Info", withExtension: "plist"),
            let plistData = try? Data(contentsOf: plistURL),
            let plist = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil),
            let plistDictionary = plist as? [String: Any] else {
                // Can't read the plist :(
                return
        }

        let appsThatNeedAScheme = NavigationApp.allCases.removing(.appleMaps).map({ $0.rawValue })

        if let queries = plistDictionary["LSApplicationQueriesSchemes"] as? [String] {
            let notFoundSchemes = appsThatNeedAScheme.filter({ !queries.contains($0) })
            if notFoundSchemes.isNotEmpty {
                preconditionFailure("Dear developer, please add the following entries to LSApplicationQueriesSchemes in your Info.plist: \(notFoundSchemes)")
            }
        } else {
            preconditionFailure("Dear developer, please add LSApplicationQueriesSchemes to your Info.plist with the following entries: \(appsThatNeedAScheme)")
        }
    }
}
