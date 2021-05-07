//
//  UnifiedViewController.swift
//  Unified
//
//  Created by Jara De Prest on 23/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import AnswerBotSDK
import ChatProvidersSDK
import ChatSDK
import CommonUISDK
import MessagingAPI
import MessagingSDK
import SDKConfigurations
import SupportSDK
import UIKit

public class UnifiedViewController: UIViewController, JWTAuthenticator {

    // MARK: - IBOutlets

    @IBOutlet private var errorLabel: UILabel!

    // MARK: - Properties

    private let titleString = "Unified SDK"
    private var engines: [Engine] = []

    private var showsAnswerBotEngine = true
    private var showsChatEngine = true
    private var showsSupportEngine = true

    private var shouldReload = true

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        Chat.instance?.setIdentity(authenticator: self)

        navigationItem.title = titleString
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.isTranslucent = false

        CommonTheme.currentTheme.primaryColor = UIColor.colorFromHex("#2f2a95")

        NotificationCenter.default.addObserver(self, selector: #selector(authFailed), name: Chat.NotificationAuthenticationFailed, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(userDidChange), name: .userUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAnswerBotEngine(_:)), name: .showAnswerBotEngine, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showChatEngine(_:)), name: .showChatEngine, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSupportEngine(_:)), name: .showSupportEngine, object: nil)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Check if identity was set already
        if Chat.instance?.hasIdentity == false {
            Chat.instance?.setIdentity(authenticator: self)
        }

        if shouldReload {
            // Remove possible old ChildVC
            if !children.isEmpty {
                let viewControllers = children
                for vc in viewControllers {
                    vc.willMove(toParent: nil)
                    vc.view.removeFromSuperview()
                    vc.removeFromParent()
                }
            }
            // Reset engines
            engines = []

            // Add new ChildVC
            do {
                let vc = try buildViewController()
                addChild(vc)
                vc.view.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(vc.view)
                NSLayoutConstraint.activate([vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                             vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                                             vc.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                             vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)])

                vc.didMove(toParent: self)
            } catch {
                if engines.isEmpty {
                    errorLabel.text = "You have to select at least one engine in your settings."
                } else {
                    showError(error)
                }
            }
            shouldReload = false
        }
    }
}

// MARK: - Private methods

private extension UnifiedViewController {
    func buildViewController() throws -> UIViewController {
        let messagingConfig = MessagingConfiguration()

        if showsAnswerBotEngine {
            let answerBotEngine = try AnswerBotEngine.engine()
            engines.append(answerBotEngine)
        }

        if showsSupportEngine {
            let supportEngine = try SupportEngine.engine()
            engines.append(supportEngine)
        }

        if showsChatEngine {
            let chatEngine = try ChatEngine.engine()
            engines.append(chatEngine)
        }

        return try Messaging.instance.buildUI(engines: engines, configs: [messagingConfig])
    }

    func showError(_ error: Error) {
        errorLabel.text = error.localizedDescription
    }
}

// MARK: - Public methods

public extension UnifiedViewController {
    func getToken(_ completion: @escaping (String?, Error?) -> Void) {
        completion(Unified.getAuthInfo().token, Unified.getAuthInfo().error)
    }
}

// MARK: - Selectors

private extension UnifiedViewController {
    @objc func authFailed(_ notification: Notification) {
        guard let error = notification.userInfo?[NSUnderlyingErrorKey] as? AuthenticationError else { return }
        switch error {
        case .invalidAccessToken(let token):
            print("🔴 Token is invalid: ", token)
        case .invalidAccountKey(let key):
            print("🔴 AccountKey is invalid: ", key)
        case .invalidSharedSecret(let secret):
            print("🔴 Shared secret is invalid: ", secret)
        case .tokenHasExpired:
            print("🔴 Token has expired")
        case .invalidEmail:
            print("🔴 Invalid email.")
        case .invalidName:
            print("🔴 Invalid name.")
        case .externalUserIdHasChanged:
            print("🔴 UserId changed.")
        case .internalServerError, .internalError, .networkError:
            print("🔴 Something went wrong: ", error.localizedDescription)
        @unknown default:
            print("🔴 Something went wrong: ", error.localizedDescription)
        }
    }

    @objc func userDidChange() {
        shouldReload = true
    }

    @objc func showAnswerBotEngine(_ notification: Notification) {
        guard let isVisible = notification.userInfo?[kIsVisible] as? Bool else { return }
        showsAnswerBotEngine = isVisible
        shouldReload = true
    }

    @objc func showChatEngine(_ notification: Notification) {
        guard let isVisible = notification.userInfo?[kIsVisible] as? Bool else { return }
        showsChatEngine = isVisible
        shouldReload = true
    }

    @objc func showSupportEngine(_ notification: Notification) {
        guard let isVisible = notification.userInfo?[kIsVisible] as? Bool else { return }
        showsSupportEngine = isVisible
        shouldReload = true
    }
}
