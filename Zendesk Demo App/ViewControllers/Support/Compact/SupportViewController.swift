//
//  SupportViewController.swift
//  test zendesk
//
//  Created by Jara De Prest on 23/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import SupportSDK
import UIKit

private enum Row: Int, CaseIterable {
    case guide
    case newTicket
    case myTickets
}

class SupportViewController: UITableViewController {

    // MARK: - Properties

    private let titleString = "Support SDK"

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = titleString
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
}

// MARK: - Internal methods

extension SupportViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Row.allCases[indexPath.row] {
        case .guide:
            navigationController?.show(SupportHelper.getGuideViewController(), sender: self)
        case .newTicket:
            navigationController?.show(SupportHelper.getNewTicketViewController(), sender: self)
        case .myTickets:
            navigationController?.show(SupportHelper.getMyTicketsViewController(), sender: self)
        }
    }
}
