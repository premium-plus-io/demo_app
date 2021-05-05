//
//  RootSplitViewController.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 30/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import UIKit

class RootSplitViewController: UISplitViewController {

    override var displayMode: UISplitViewController.DisplayMode {
        .twoBesideSecondary
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presentsWithGesture = false

        setViewController(MainSideBarController(), for: .primary)
        setViewController(MainTabBarViewController(), for: .compact)

        if !UserService.shared.isLoggedIn {
            UserService.shared.login { _ in }
        } else {
            UserService.shared.getToken()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
    }
}
