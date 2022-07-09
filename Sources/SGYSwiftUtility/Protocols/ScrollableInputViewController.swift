//
//  ScrollableInputViewController.swift
//  
//
//  Created by Sean Young on 7/9/22.
//

#if canImport(UIKit)

import UIKit

@available(iOS 13, *)
public protocol ScrollableInputViewController: ScrollableViewController & ScrollViewInputHandler { }

/// Combines `ScrollableViewController` and `ScrollViewInputHandler`.
@available(iOS 13, *)
extension ScrollableInputViewController {
    /// Sets up the controller's main view with a scroll view which contains a content view to place content on that can be scrolled in the specified direction. Optionally also registers keyboard observers for modifying offset when keyboard is displayed.
    /// - Parameters:
    ///   - scrollableAxis: The direction to allow scrolling in.
    ///   - registerObservers: Whether to register keyboard observers in order to modify content when keyboard is shown. Defaults to `true`.
    public func setupContentView(withScrollableAxis scrollableAxis: NSLayoutConstraint.Axis, registerObservers: Bool = true) {
        (self as ScrollableViewController).setupContentView(withScrollableAxis: scrollableAxis)
        if registerObservers { registerKeyboardObservers() }
    }
}

#endif
