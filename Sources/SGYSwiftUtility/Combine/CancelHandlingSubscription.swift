//
//  CancelHandlingSubscription.swift
//  
//
//  Created by Sean Young on 6/5/22.
//

import Foundation

#if canImport(Combine)

import Combine

@available(iOS 13, macOS 10.15, *)
open class CancelHandlingSubscription<Target: Subscriber>: Subscription {
    
    // MARK: - Initialization
    
    public init(target: Target, onCancel cancelBlock: @escaping () -> Void) {
        self.target = target
        self.cancelBlock = cancelBlock
    }
    
    // MARK: - Properties
    
    public var target: Target?
    public let cancelBlock: () -> Void
    
    // MARK: - Methods

    // Unused currently
    public func request(_ demand: Subscribers.Demand) {
        // Nothing to do
    }

    public func cancel() {
        // Execute cancel block
        cancelBlock()
        // Release target
        target = nil
    }
}

#endif

