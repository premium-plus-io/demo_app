//
//  WebViewController.swift
//  test zendesk
//
//  Created by Jara De Prest on 23/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import UIKit
import WebKit

var premiumplusUrl: URL? { URL(string: "https://premiumplus.coffee") }

class WebViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties

    private let titleString = "Web"
    private var webView = WKWebView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = titleString
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        setupWebView()

        NotificationCenter.default.addObserver(self, selector: #selector(urlChanged(_:)), name: .webUrlChanged, object: nil)
    }
}

// MARK: - IBActions

private extension WebViewController {
    @IBAction func reload() {
        webView.reload()
    }
}

// MARK: - Private methods

private extension WebViewController {
    func setupWebView() {
        webView.navigationDelegate = self
        view = webView

        if let url = premiumplusUrl {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}

// MARK: - Selectors

private extension WebViewController {
    @objc func urlChanged(_ notification: Notification) {
        guard
            let urlString = notification.userInfo?[kUrl] as? String,
            let url = URL(string: urlString)
        else {
            // Load default url
            if let url = premiumplusUrl {
                webView.load(URLRequest(url: url))
            }
            return }

        webView.load(URLRequest(url: url))
    }
}
