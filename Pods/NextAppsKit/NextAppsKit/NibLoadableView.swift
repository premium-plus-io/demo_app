//
//  NibLoadableView.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe & Robbe Vandecasteele on 05/10/2018.
//  Copyright © 2018 Next Apps. All rights reserved.
//

import UIKit

public protocol ReusableView {
    static var defaultReuseIdentifier: String { get }
}

extension UIView: ReusableView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - NibLoadableView

public protocol NibLoadableView {
    static var nibName: String { get }
}

extension UIView: NibLoadableView {
    public static var nibName: String {
        return String(describing: self)
    }
}

// MARK: - UICollectionView

extension UICollectionView {
    public func register<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func register<T: UICollectionReusableView>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forSupplementaryViewOfKind: String(describing: T.self), withReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func registerReusableSectionHeader<T: UICollectionReusableView>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func registerReusableSectionFooter<T: UICollectionReusableView>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    public func dequeueCell<T: UICollectionViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueReusableSectionHeader<T: UICollectionReusableView>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueReusableSectionFooter<T: UICollectionReusableView>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: String(describing: T.self), withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
    
}

// MARK: - UITableView

extension UITableView {
    public func register<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func register<T: UITableViewHeaderFooterView>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    public func dequeueCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(ofType type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as! T
    }
    
}

// MARK: - UINib

extension UINib {
    static public func initView<T: UIView>(ofType: T.Type) -> T {
        return Bundle.main.loadNibNamed(T.nibName, owner: self, options: nil)?.first as! T
    }
}
