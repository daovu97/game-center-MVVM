//
//  UITableview+Extension.swift
//  AutoLayoutEx2
//
//  Created by daovu on 9/5/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Couldn't dequeueReusableCell \(cellType.className)")
        }
    }
    
    func scrollToTop(animated: Bool) {
        scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: animated)
    }
}

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.className)
    }
    
    func registerCell<T: UICollectionReusableView>(_ cellType: T.Type, forSupplementaryViewOfKind: String) {
        register(cellType.self, forSupplementaryViewOfKind: forSupplementaryViewOfKind,
                 withReuseIdentifier: cellType.className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: cellType.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Couldn't dequeueReusableCell \(cellType.className)")
        }
    }
    
    func dequeueReusableCell<T: UICollectionReusableView>(_ cellType: T.Type,
                                                          ofKind elementKind: String,
                                                          for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableSupplementaryView(ofKind: elementKind,
                                                       withReuseIdentifier: cellType.className,
                                                       for: indexPath) as? T {
            return cell
        } else {
            fatalError("Couldn't dequeueReusableCell \(cellType.className)")
        }
    }
    
    func scrollToLast() {
        guard numberOfSections > 0 else {
            return
        }

        let lastSection = numberOfSections - 1

        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }

        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
}
