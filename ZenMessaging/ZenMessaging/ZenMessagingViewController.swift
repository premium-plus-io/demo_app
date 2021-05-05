//
//  ZenMessagingViewController.swift
//  ZenMessaging
//
//  Created by Simon Salomons on 27/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import ChatProvidersSDK
import UIKit
import ZendeskSDKMessaging

public class ZenMessagingViewController: UIViewController {

    // MARK: - Properties

    private var key = "eyJzZXR0aW5nc191cmwiOiJodHRwczovL3ByZW1pdW1wbHVzZGVtby56ZW5kZXNrLmNvbS9tb2JpbGVfc2RrX2FwaS9zZXR0aW5ncy8wMUY0NllENFpTWEhDWEtDVFFaSFJON1ZLWC5qc29uIn0="
    private var messaging: Messaging?
    private let titleString = "Zendesk SDK"

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = titleString
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

        Messaging.initialize(channelKey: key, completionHandler: { [weak self] result in
            self?.messaging = try? result.get()
        })
    }
}

// MARK: - IBActions

private extension ZenMessagingViewController {
    @IBAction func showZendesk() {
        guard let vc = messaging?.messagingViewController() else { return }
        navigationController?.show(vc, sender: self)
    }
}
