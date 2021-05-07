//
//  SettingsViewController.swift
//  test zendesk
//
//  Created by Jara De Prest on 23/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import Auth0
import UIKit
import Unified

var kUrl: String { "kUrl" }

class SettingsViewController: UITableViewController {

    // MARK: - IBOutlets

    // Unified SDK Features
    @IBOutlet private var answerBotSwitch: UISwitch!
    @IBOutlet private var chatSwitch: UISwitch!
    @IBOutlet private var supportSwitch: UISwitch!
    // Login
    @IBOutlet private var loginButton: UIButton!
    // Logout
    @IBOutlet private var loggedInLabel: UILabel!
    @IBOutlet private var logoutButton: UIButton!
    // Web View
    @IBOutlet private var webViewTextField: UITextField!

    // MARK: - Properties

    private let titleString = "Settings"

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = titleString
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.isTranslucent = false

        webViewTextField.delegate = self
        webViewTextField.text = premiumplusUrl?.absoluteString
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loginButton.isEnabled = !UserService.shared.isLoggedIn
        logoutButton.isEnabled = UserService.shared.isLoggedIn

        if UserService.shared.isLoggedIn {
            guard let email = UserService.shared.user?.email else { return }
            loggedInLabel.text = "Currently logged in as \(email)"
        } else {
            loggedInLabel.text = "Currently not logged in."
        }
    }
}

// MARK: - IBActions

private extension SettingsViewController {
    @IBAction func login() {
        UserService.shared.login { success in
            if success {
                DispatchQueue.main.async {
                    self.loginButton.isEnabled = false
                    self.logoutButton.isEnabled = true
                    guard let email = UserService.shared.user?.email else { return }
                    self.loggedInLabel.text = "Currently logged in as \(email)"
                }
            }
        }
    }

    @IBAction func logout() {
        UserService.shared.logout { success in
            if success {
                self.loggedInLabel.text = "Currently not logged in."
                self.logoutButton.isEnabled = false
                self.loginButton.isEnabled = true
            }
        }
    }

    @IBAction func switchAnswerBotChanged() {
        Unified.showAnswerBotEngine(answerBotSwitch.isOn)
    }

    @IBAction func switchChatChanged() {
        Unified.showChatEngine(chatSwitch.isOn)
    }

    @IBAction func switchSupportChanged() {
        Unified.showSupportEngine(supportSwitch.isOn)
    }
}

// MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let url = textField.text else { return }
        NotificationCenter.default.post(name: .webUrlChanged, object: nil, userInfo: [kUrl: url])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
