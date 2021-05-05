//
//  HorizontalPagingCollectionViewProtocol.swift
//  NextAppsKit
//
//  Created by Simon Salomons on 29/05/2020.
//  Copyright © 2020 Next Apps. All rights reserved.
//

import UIKit

/// Helper protocol to avoid duplicate code for horizontal paging scrollview effect in a collectionview
public protocol HorizontalPagingCollectionViewProtocol: AnyObject {
    var itemWidth: CGFloat { get }
    var indexOfCellBeforeDragging: Int { get set }
}

public extension HorizontalPagingCollectionViewProtocol {
    func handleScrollViewWillBeginDragging(collectionView: UICollectionView) {
        indexOfCellBeforeDragging = indexOfMostVisibleCard(collectionView: collectionView)
    }

    func handleScrollViewWillEndDragging(collectionView: UICollectionView, velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        // Stop scrollView sliding:
        targetContentOffset.pointee = collectionView.contentOffset

        // calculate where scrollView should snap to:
        let indexOfMajorCell = indexOfMostVisibleCard(collectionView: collectionView)

        // calculate conditions:
        let dataSourceCount = collectionView.numberOfItems(inSection: 0)
        let swipeVelocityThreshold: CGFloat = 0.5
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let didUseSwipeToSkipCell = hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell

        if didUseSwipeToSkipCell {
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = (itemWidth + flowLayout.minimumInteritemSpacing) * CGFloat(snapToIndex)

            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                collectionView.contentOffset = CGPoint(x: toValue, y: 0)
                collectionView.layoutIfNeeded()
            }, completion: nil)
        } else {
            let index = min(indexOfMajorCell, collectionView.numberOfItems(inSection: 0) - 1)
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    func indexOfMostVisibleCard(collectionView: UICollectionView) -> Int {
        let proportionalOffset = collectionView.contentOffset.x / itemWidth + 0.5
        return Int(proportionalOffset)
    }
}

