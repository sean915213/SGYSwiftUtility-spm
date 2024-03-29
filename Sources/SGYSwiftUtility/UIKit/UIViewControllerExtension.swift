//
//  UIViewControllerExtension.swift
//  Pods-SGYSwiftUtility_Tests
//
//  Created by Sean G Young on 9/24/18.
//

#if canImport(UIKit)

import UIKit

extension UIViewController {
    
    public func addChild(_ child: UIViewController, withConfigureViewBlock configureBlock: (UIView) -> Void) {
        addChild(child)
        configureBlock(child.view)
        child.didMove(toParent: self)
    }
    
    public func removeFromParent(withRemoveViewBlock removeBlock: () -> Void) {
        willMove(toParent: nil)
        removeBlock()
        removeFromParent()
    }
    
    @available(iOS 15, *)
    /// Configures a view controller's `UISheetPresentationController` with common values for sheet presentation. Also adds additional logic like increasing safe area insets when grabber is visible.
    /// - Parameters:
    ///   - detents: The `Detent`s or sizes to allow the sheet to expand to.
    ///   - preferGrabberVisible: Whether to prefer displaying the grabber at the top of the controller. If true, the top safe area insets will be increased to account for the grabber.
    public func configureForSheetPresentation(withDetents detents: [UISheetPresentationController.Detent] = [.medium(), .large()], preferGrabberVisible: Bool = true) {
        guard let sheet = sheetPresentationController else { return }
        sheet.detents = detents
        sheet.prefersGrabberVisible = preferGrabberVisible
        // If grabber visible then increase the safe area
        if preferGrabberVisible { additionalSafeAreaInsets.top = 8 }
    }
    
    /// Dismisses the `UIViewController` based on how it was presented. I.e.- if pushed on the navigation stack it will be popped back to the presenting controller. If presented, it will be dismissed.
    /// - Parameters:
    ///   - controller: The view controller to dismiss.
    ///   - animated: Whether to animate the dismissal.
    public func globalDismiss(controller: UIViewController, animated: Bool = true) {
        if navigationController?.viewControllers.contains(controller) == true {
            navigationController?.popToViewController(self, animated: animated)
        } else {
            controller.dismiss(animated: animated)
        }
    }
}

#endif
