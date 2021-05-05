//
//  Notification.Name+Extensions.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 26/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var authStateChanged: NSNotification.Name { Notification.Name("AuthStateChanged") }
    static var webUrlChanged: NSNotification.Name { Notification.Name("WebUrlChanged") }
}
