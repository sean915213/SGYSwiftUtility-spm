//
//  UIContentViewConfiguration.swift
//  
//
//  Created by Sean Young on 5/9/22.
//

#if canImport(UIKit)

import UIKit

@available(iOS 14, *)
extension UIContentView {
    
    /// Returns the `configuration` value cast to type `T`.
    /// - Parameter type: The type to cast the configuration value to.
    /// - Returns: The configuration as type `T` or nil if it could not be cast.
    public func configuration<T>(ofType type: T.Type) -> T? where T: UIContentConfiguration {
        return configuration as? T
    }
}

#endif
