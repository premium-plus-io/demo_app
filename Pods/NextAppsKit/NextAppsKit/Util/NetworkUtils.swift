//
//  NetworkUtils.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 10/08/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

extension HTTPURLResponse {
	
	public var isOK: Bool {
		return statusCode == 200
	}
	
	public var isUnauthorized: Bool {
		return statusCode == 401
	}
	
}

extension UIDevice {
	
	public var isConnectedToNetwork: Bool {
		
		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
		zeroAddress.sin_family = sa_family_t(AF_INET)
		
		guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
				SCNetworkReachabilityCreateWithAddress(nil, $0)
			}
		}) else {
			return false
		}
		
		var flags: SCNetworkReachabilityFlags = []
		if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
			return false
		}
		
		let isReachable = flags.contains(.reachable)
		let needsConnection = flags.contains(.connectionRequired)
		
		return (isReachable && !needsConnection)
	}
	
}
