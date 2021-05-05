//
//  SupportHelper.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 30/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import SupportSDK
import UIKit

enum SupportHelper {

    static func getGuideViewController() -> UIViewController {
        let hcConfig = HelpCenterUiConfiguration()
        hcConfig.labels = ["ios", "xcode"]

        return HelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [hcConfig])
    }

    static func getNewTicketViewController() -> UIViewController {
        let config = RequestUiConfiguration()
        config.subject = "iOS Ticket"
        config.tags = ["ios", "mobile"]

        return RequestUi.buildRequestUi(with: [config])
    }

    static func getMyTicketsViewController() -> UIViewController {
        RequestUi.buildRequestList()
    }
}
