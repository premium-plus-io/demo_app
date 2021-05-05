//
//  UIImage+Download.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 03/08/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
	
	@discardableResult
	static func download(from url: URL, callback: @escaping (UIImage?) -> ()) -> URLSessionDataTask {
		
		let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else {
					
					callback(nil)
					return
					
			}
			
			DispatchQueue.main.async() { () -> Void in
				callback(image)
			}
			
		}
		
		dataTask.resume()
		
		return dataTask
	}
	
}
