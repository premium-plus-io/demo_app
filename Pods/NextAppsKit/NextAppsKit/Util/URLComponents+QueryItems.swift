//
//  URLComponents+QueryItems.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 17/07/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

extension URLComponents {
	
	public func queryItemValue(for queryName: String) -> String? {
		
		guard let queryItem = queryItems?.first(where: { $0.name == queryName }) else {
			return nil
		}
		
		return queryItem.value
	}
	
}
