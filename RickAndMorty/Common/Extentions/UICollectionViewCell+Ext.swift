//
//  UICollectionViewCell+Ext.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("Error: cell with id: \(cellClass.identifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
