//
//  MainSideBarController.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 30/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import UIKit
import Unified
import ZenMessaging

enum Section: String {
    case zendesk
}

enum TabsViewModel: String, CaseIterable {
    case web
    case zendesk
    case unified
    case support
    case settings

    var icon: UIImage? {
        switch self {
        case .web:
            return UIImage(systemName: "globe")
        case .zendesk:
            return UIImage(systemName: "questionmark.circle")
        case .unified:
            return UIImage(systemName: "lifepreserver")
        case .support:
            return UIImage(systemName: "ticket")
        case .settings:
            return UIImage(systemName: "gear")
        }
    }

    var title: String {
        rawValue.capitalizedFirstLetter
    }

    var primaryViewController: UIViewController {
        switch self {
        case .web:
            return ViewControllerFactory.webViewController()
        case .zendesk:
            return ViewControllerFactory.zendeskViewController()
        case .unified:
            return ViewControllerFactory.unifiedViewController()
        case .support:
            return ViewControllerFactory.supportViewController()
        case .settings:
            return ViewControllerFactory.settingsViewController()
        }
    }
}

class MainSideBarController: UIViewController {

    private var collectionView: UICollectionView?
    private var dataSource: UICollectionViewDiffableDataSource<Section, TabsViewModel>?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Zendesk SDK"
        navigationController?.navigationBar.prefersLargeTitles = true

        configureHierarchy()
        configureDataSource()
        setInitialSecundaryView()
    }
}

// MARK: - Private methods

private extension MainSideBarController {
    func setInitialSecundaryView() {
        collectionView?.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
        splitViewController?.setViewController(UINavigationController(rootViewController: TabsViewModel.allCases[0].primaryViewController), for: .secondary)
    }

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
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
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, TabsViewModel> { cell, _, item in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.image = item.icon
            cell.contentConfiguration = content
            cell.accessories = []
        }

        guard let collectionView = collectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, TabsViewModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: TabsViewModel) -> UICollectionViewCell? in

            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        let sections: [Section] = [.zendesk]
        var snapshot = NSDiffableDataSourceSnapshot<Section, TabsViewModel>()
        snapshot.appendSections(sections)
        dataSource?.apply(snapshot, animatingDifferences: false)

        for section in sections {
            var sectionSnapShot = NSDiffableDataSourceSectionSnapshot<TabsViewModel>()
            sectionSnapShot.append(TabsViewModel.allCases)
            dataSource?.apply(sectionSnapShot, to: section)
        }
    }
}

// MARK: - UICollectionView Delegate

extension MainSideBarController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }

        if TabsViewModel.allCases[indexPath.row] == .support {
            splitViewController?.setViewController(SupportSideBarViewController(), for: .supplementary)
        } else {
            splitViewController?.setViewController(nil, for: .supplementary)
        }

        splitViewController?.setViewController(UINavigationController(rootViewController: TabsViewModel.allCases[indexPath.row].primaryViewController), for: .secondary)
    }
}
