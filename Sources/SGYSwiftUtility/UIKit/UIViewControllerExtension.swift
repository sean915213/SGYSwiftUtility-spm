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
}

#endif
