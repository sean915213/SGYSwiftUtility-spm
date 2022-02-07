//
//  UIViewExtension.swift
//  Pods
//
//  Created by Sean G Young on 2/13/16.
//
//

#if canImport(UIKit)

import UIKit

extension UIView {
    
    /**
     Initializes a `UIView` instance and sets the provided `translatesAutoresizingMask` parameter.
     
     - parameter translatesAutoresizingMask: The value to set for the view's `translatesAutoResizingMaskIntoConstraints` property.
     
     - returns: An initialized `UIView` instance.
     */
    public convenience init(translatesAutoresizingMask: Bool) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMask
    }
    
    /**
     Adds the array of `UIView` to the view.
     
     - parameter views: An array of `UIView` instances to add to this view.
     */
    public func addSubviews(_ views: [UIView]) {
        for view in views { addSubview(view) }
    }
    
    /// Adds subviews to the receiver.
    /// - Parameter views: The subviews to add.
    public func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
    /// Walks through a view and its all subviews to find the current first responder if it exists.
    /// - Returns: The view that is currently the first responder or `nil` if it was not found.
    public func findFirstResponder() -> UIView? {
        guard !isFirstResponder else { return self }
        for view in subviews {
            if let responder = view.findFirstResponder() { return responder }
        }
        return nil
    }
}

#endif
