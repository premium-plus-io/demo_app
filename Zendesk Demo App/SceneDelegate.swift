//
//  SceneDelegate.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 26/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard scene as? UIWindowScene != nil else { return }

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let splitVC = RootSplitViewController(style: .tripleColumn)
            splitVC.preferredDisplayMode = .twoBesideSecondary
            splitVC.preferredSplitBehavior = .tile

            window.rootViewController = splitVC
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
