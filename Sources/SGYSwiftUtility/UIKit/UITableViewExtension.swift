//
//  UITableViewExtension.swift
//  Pods
//
//  Created by Sean G Young on 2/13/16.
//
//

#if canImport(UIKit)

import UIKit

extension UITableView {
    
    public func register<T: RawRepresentable>(_ cellClass: UITableViewCell.Type, forCellReuseIdentifier reuseIdentifier: T) where T.RawValue == String {
        self.register(cellClass, forCellReuseIdentifier: reuseIdentifier.rawValue)
    }
    
    public func register<T>(_ cellClass: UITableViewCell.Type, forCellReuseIdentifiers identifiers: T.Type) where T: RawRepresentable & CaseIterable, T.RawValue == String {
        identifiers.allCases.forEach { register(cellClass, forCellReuseIdentifier: $0) }
    }
    
    public func dequeueReusableCell<T: RawRepresentable, U: UITableViewCell>(withIdentifier identifier: T, for indexPath: IndexPath) -> U where T.RawValue == String {
        return self.dequeueReusableCell(withIdentifier: identifier.rawValue, for: indexPath)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    /**
     Attempts dequeueing a registered `UITableViewHeaderFooterView` and casting to type `T` before returning.
     
     - parameter identifier: The view's registered `reuseIdentifier`.
     
     - returns: A dequeued `UITableViewHeaderFooterView` cast to `T`.  Returns `nil` if no reusable view was found in the queue.
     */
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier identifier: String) -> T? {
        // Check view can be returned before force casting
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) else { return nil }
        // Force cast
        return (view as! T)
    }
}

#endif
