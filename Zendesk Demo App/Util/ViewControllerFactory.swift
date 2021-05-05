//
//  ViewControllerFactory.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 30/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import NextAppsKit

private enum Storyboard: String {
    case web
    case zendesk
    case unified
    case support
    case settings

    private var storyboard: UIStoryboard {
        UIStoryboard(name: rawValue.capitalizedFirstLetter, bundle: nil)
    }

    fileprivate func initialViewController() -> UIViewController {
        guard let viewController = storyboard.instantiateInitialViewController() else {
            fatalError("No initial viewcontroller in storyboard \(rawValue.capitalized)")
        }
        return viewController
    }

    fileprivate func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T {
        let identifier = String(describing: type.self)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("No viewcontroller of type \(identifier) in storyboard \(rawValue.capitalized)")
        }
        return viewController
    }
}

enum ViewControllerFactory {

    // MARK: - Web

    static func webViewController() -> UIViewController {
        Storyboard.web.instantiateViewController(ofType: WebViewController.self)
    }

    // MARK: - Zendesk

    static func zendeskViewController() -> UIViewController {
        Storyboard.zendesk.initialViewController()
    }

    // MARK: - Unified

    static func unifiedViewController() -> UIViewController {
        Storyboard.unified.initialViewController()
    }

    // MARK: - Support

    static func supportViewController() -> UIViewController {
        Storyboard.support.initialViewController()
    }

    // MARK: - Settings

    static func settingsViewController() -> UIViewController {
        Storyboard.settings.initialViewController()
    }
}
