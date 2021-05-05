//
//  String+Localization.swift
//  NextAppsKit
//
//  Created by Andrew Haentjens on 31/03/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import Foundation

internal extension String {
    func localized() -> String {
        let localized = NSLocalizedString(self, bundle: Bundle.module, comment: "")
        
        if localized == self {
            print("🛑 It seems your app is using a language unsupported by NextAppsKit. Reverting to English")
            
            if
                let path = Bundle.module.path(forResource: "en", ofType: "lproj"),
                let bundle = Bundle(path: path) {
                    return bundle.localizedString(forKey: self, value: nil, table: nil)
            }
        }
        
        return localized
    }
}
