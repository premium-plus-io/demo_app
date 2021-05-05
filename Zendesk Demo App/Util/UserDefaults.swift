//
//  UserDefaults.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 26/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import NextAppsKit
import UIKit

extension UserDefaults {
    @UserDefault("UserId") static var userId: String?
    @UserDefault("User") static var user: User?
}
