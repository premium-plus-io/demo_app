//
//  MainTabBarViewController.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 26/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    private lazy var tabViewControllers = makeViewControllers()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabViewControllers

        tabBar.isTranslucent = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        selectedIndex = 0
    }
}

// MARK: - Private extension

private extension MainTabBarViewController {
    func makeViewControllers() -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        var tag = 0

        for tabItem in TabsViewModel.allCases {
            let vc = UINavigationController(rootViewController: tabItem.primaryViewController)
            vc.tabBarItem = UITabBarItem(title: tabItem.title, image: tabItem.icon, tag: tag)
            viewControllers.append(vc)
            tag += 1
        }

        return viewControllers
    }
}
