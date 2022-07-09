//
//  ScrollableInputViewController.swift
//  
//
//  Created by Sean Young on 7/9/22.
//

#if canImport(UIKit)

import UIKit

public protocol ScrollableInputViewController: ScrollableViewController & ScrollViewInputHandler { }

extension ScrollableInputViewController {
    
    public func setupContentView(withScrollableAxis scrollableAxis: NSLayoutConstraint.Axis, registerObservers: Bool = true) {
        (self as ScrollableViewController).setupContentView(withScrollableAxis: scrollableAxis)
        if registerObservers { registerKeyboardObservers() }
    }
    
}

#endif
