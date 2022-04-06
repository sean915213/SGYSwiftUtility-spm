//
//  UIScrollViewExtension.swift
//  
//
//  Created by Sean Young on 4/6/22.
//

#if canImport(UIKit)

import UIKit

extension UIScrollView {
    
    /// Scrolls the specified view's frame into view if possible.
    /// - Parameters:
    ///   - view: The view to scroll into the frame.
    ///   - animated: Whether to animate the scrolling.
    public func scrollToView(_ view: UIView, animated: Bool) {
        let rect = convert(view.frame, from: view.superview)
        scrollRectToVisible(rect, animated: true)
    }
}

#endif
