//
//  ScrollableViewController.swift
//  
//
//  Created by Sean Young on 1/13/22.
//

import UIKit

/// A protocol helping view controllers to create content scrollable in a single direction.
public protocol ScrollableViewController: UIViewController {
    /// The scroll view to use.
    var scrollView: UIScrollView { get }
    /// The main view to place content on.
    var contentView: UIView { get }
}

extension ScrollableViewController {
    /// Sets up the controller's main view with a scroll view which contains a content view to place content on that can be scrolled in the specified direction.
    /// - Parameter scrollableAxis: The direction to allow scrolling in.
    public func setupContentView(withScrollableAxis scrollableAxis: NSLayoutConstraint.Axis) {
        // Add scrollView and pin to all sides of main view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.constraintsPinningView(scrollView).activate()
        // Add content view to scrollView and center
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.constraintsPinningView(contentView, toLayoutGuide: scrollView.contentLayoutGuide).activate()
        // Depending on axis add additional constraints
        switch scrollableAxis {
        case .vertical:
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).activate()
        case .horizontal:
            contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor).activate()
        @unknown default:
            assertionFailure("Unhandled axis case: \(scrollableAxis)")
        }
    }
}
