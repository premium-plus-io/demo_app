//
//  Notification.Name+Extensions.swift
//  Unified
//
//  Created by Jara De Prest on 29/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var userUpdated: NSNotification.Name { Notification.Name("UserUpdated") }
    static var showAnswerBotEngine: NSNotification.Name { Notification.Name("ShowAnswerBotEngine") }
    static var showChatEngine: NSNotification.Name { Notification.Name("ShowChatEngine") }
    static var showSupportEngine: NSNotification.Name { Notification.Name("ShowSupportEngine") }
}
