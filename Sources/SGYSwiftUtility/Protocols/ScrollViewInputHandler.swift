//
//  ScrollViewInputHandler.swift
//  
//
//  Created by Sean Young on 1/13/22.
//

#if canImport(UIKit)
#if canImport(Combine)

import UIKit
import Combine

/// Simplifies the implementation of logic that scrolls first responders into view upon activating the keyboard. Adopters need only to call `registerKeyboardObservers()` to gain basic functionality.
public protocol ScrollViewInputHandler: UIViewController {
    var scrollView: UIScrollView { get }
    var keyboardObservers: [AnyCancellable] { get set }
}

extension ScrollViewInputHandler {
    
    /// Registers the necessary notification observers to detect when the keyboard is displayed and therefore scroll any first responders into view.
    public func registerKeyboardObservers() {
        // Make sure this is only called once per object lifetime
        assert(keyboardObservers.isEmpty, "\(#function) should only be called once per object lifetime. This is a programmer error and the logic should be cleaned up.")
        // This logic does not work properly when this class inherits from UITableViewController. This will cause weird issues due to its own poorly implemented scrolling logic.
        assert(!(self is UITableViewController), "This protocol will not function properly in a class inheriting from UITableViewController.")
        // Add observers for keyboard notifications
        // NOTE: The [unowned self] directive is important to avoid reference cycles
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification).sink { [unowned self] notification in
            keyboardWillShow(notification: notification)
        }.store(in: &keyboardObservers)
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).sink { [unowned self] notification in
            keyboardWillHide(notification: notification)
        }.store(in: &keyboardObservers)
    }
    
    private func keyboardWillShow(notification: Notification) {
        // Check whether scrollView's contentSize has a non-zero width. If it does, this won't work and is difficult to debug.
        assert(scrollView.contentSize.width > 0, "ScrollView's contentSize.width must be non-zero to scroll the keyboard for input. This is likely a layout error and should be fixed.")
        // Get keyboard end frame
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        // We don't expect this to ever be called without an assigned window, but be safe
        guard let viewWindow = view.window else { return }
        // Convert our scroll view frame to window's
        let scrollFrame = viewWindow.convert(scrollView.frame, from: scrollView.superview)
        // Get intersection of scrollView and keyboard
        let intersection = scrollFrame.intersection(keyboardFrame)
        // Assign content insets
        scrollView.contentInset.bottom = intersection.height - scrollView.safeAreaInsets.bottom
        scrollView.verticalScrollIndicatorInsets.bottom = intersection.height - scrollView.safeAreaInsets.bottom
        // Get current responder's frame
        guard let responderView = scrollView.findFirstResponder() else { return }
        let responderFrame = scrollView.convert(responderView.frame, from: responderView.superview)
        // Scroll responder into view
        scrollView.scrollRectToVisible(responderFrame, animated: true)
    }
    
    private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
}

#endif
#endif
