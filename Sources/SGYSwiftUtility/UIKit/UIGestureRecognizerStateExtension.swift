//
//  UIGestureRecognizerStateExtension.swift
//  
//
//  Created by Sean G Young on 9/15/19.
//

#if canImport(UIKit)

import UIKit

extension UIGestureRecognizer.State: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .began: return "Began"
        case .cancelled: return "Cancelled"
        case .changed: return "Changed"
        case .ended: return "Ended"
        case .failed: return "Failed"
        case .possible: return "Possible"
        @unknown default: return "Unknown"
        }
    }
}

#endif
