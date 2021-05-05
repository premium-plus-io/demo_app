//
//  SupportSideBarViewController.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 30/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import UIKit

enum SupportSection: String {
    case support
}

enum SupportViewModel: String, CaseIterable {
    case guide = "Guide"
    case newTicket = "New Ticket"
    case myTickets = "My Tickets"

    var title: String {
        rawValue
    }

    var primaryViewController: UIViewController {
        switch self {
        case .guide:
            return SupportHelper.getGuideViewController()
        case .newTicket:
            return SupportHelper.getNewTicketViewController()
        case .myTickets:
            return SupportHelper.getMyTicketsViewController()
        }
    }
}

class SupportSideBarViewController: UIViewController {

    private var collectionView: UICollectionView?
    private var dataSource: UICollectionViewDiffableDataSource<SupportSection, SupportViewModel>?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Support SDK"
        navigationController?.navigationBar.prefersLargeTitles = true

        configureHierarchy()
        configureDataSource()
        setInitialSecundaryView()
    }
}

// MARK: - Private methods

private extension SupportSideBarViewController {
    func setInitialSecundaryView() {
        collectionView?.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
        splitViewController?.setViewController(UINavigationController(rootViewController: SupportViewModel.allCases[0].primaryViewController), for: .secondary)
    }

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
            config.headerMode = section == 0 ? .none : .firstItemInSection
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }

    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView?.delegate = self

        collectionView?.translatesAutoresizingMaskIntoConstraints = false

        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SupportViewModel> { cell, _, item in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
            cell.accessories = []
        }

        guard let collectionView = collectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<SupportSection, SupportViewModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: SupportViewModel) -> UICollectionViewCell? in

            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        let sections: [SupportSection] = [.support]
        var snapshot = NSDiffableDataSourceSnapshot<SupportSection, SupportViewModel>()
        snapshot.appendSections(sections)
        dataSource?.apply(snapshot, animatingDifferences: false)

        for section in sections {
            var sectionSnapShot = NSDiffableDataSourceSectionSnapshot<SupportViewModel>()
            sectionSnapShot.append(SupportViewModel.allCases)
            dataSource?.apply(sectionSnapShot, to: section)
        }
    }
}

// MARK: - UICollectionView Delegate

extension SupportSideBarViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        splitViewController?.setViewController(UINavigationController(rootViewController: SupportViewModel.allCases[indexPath.row].primaryViewController), for: .secondary)
    }
}
