//
//  UICollectionViewExtension.swift
//  Pods
//
//  Created by Sean G Young on 2/13/16.
//
//

#if canImport(UIKit)

import UIKit

extension UICollectionView {
    
    public func register<T: UICollectionViewCell, U: RawRepresentable>(_ cellClass: T.Type, forCellWithReuseIdentifier reuseIdentifier: U) where U.RawValue == String {
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifier.rawValue)
    }
    
    public func dequeueReusableCell<T: RawRepresentable, U: UICollectionViewCell>(withReuseIdentifier reuseIdentifier: T, for indexPath: IndexPath) -> U where T.RawValue == String {
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier.rawValue, for: indexPath)
    }
    
    /**
     Provides a method for dequeueing typed cells from `UICollectionView`.
     
     - parameter identifier: The `UICollectionViewCell`'s registered `reuseIdentifier`.
     - parameter indexPath:  The `NSIndexPath` to dequeue the cell for.
     
     - returns: A dequeued `UICollectionViewCell` cast to type `T`.
     */
    public func dequeueReusableCell<T: UICollectionViewCell>(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
    
    /**
     Provides a method for dequeueing typed supplementary views from `UICollectionView`.
     
     - parameter elementKind:     The kind of supplementary view.
     - parameter reuseIdentifier: The `UICollectionReusableView`'s registered `reuseIdentifier`.
     - parameter indexPath:       The `NSIndexPath` to dequeue the view for.
     
     - returns: A dequeued `UICollectionReusableView` cast to type `T`.
     */
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, withReuseIdentifier reuseIdentifier: String, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
    
    
    /// Deselects all selected items.
    /// - Parameter animated: Whether the animate the deselection.
    public func deselectAllItems(animated: Bool = true) {
        indexPathsForSelectedItems?.forEach { deselectItem(at: $0, animated: animated) }
    }
}

#endif
