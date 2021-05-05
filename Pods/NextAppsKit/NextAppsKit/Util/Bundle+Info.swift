//
//  Bundle+Info.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 22/06/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

public extension Bundle {
	
	var name: String {
		
		if let bundleName = self.infoDictionary?["CFBundleName"] as? String {
			return bundleName
		}
		
		return ""
	}
	
	var version: String {
	
		if let str = self.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
			return str
		}
		
		return "unknown"
	}
	
	var build: String {
		
		if let str = self.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
			return str
		}
		
		return "unknown"
	}
	
	var targetVersionDescription: String {
		return "\(name) v\(version) (build \(build))"
	}
    
    private static let bundleID = "org.cocoapods.NextAppsKit"

    static var module: Bundle {
        guard let path = Bundle(identifier: bundleID)?.resourcePath else { return .main }
        return Bundle(path: path.appending("/NextAppsKit.bundle")) ?? .main
    }
}
