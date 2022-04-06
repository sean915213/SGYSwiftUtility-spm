//
//  UIScrollViewExtension.swift
//  
//
//  Created by Sean Young on 4/6/22.
//

#if canImport(UIKit)

import UIKit

extension UIScrollView {
    
    public func scrollToView(_ view: UIView, animated: Bool) {
        let rect = convert(view.frame, from: view.superview)
        scrollRectToVisible(rect, animated: true)
    }
}

#endif
