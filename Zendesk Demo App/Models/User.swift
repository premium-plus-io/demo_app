//
//  User.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 28/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String?
    let name: String?
    let givenName: String?
    let familyName: String?
    let email: String?
    let emailVerified: Bool
}
