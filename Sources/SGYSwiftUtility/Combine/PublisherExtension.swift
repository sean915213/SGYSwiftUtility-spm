//
//  PublisherExtension.swift
//  
//
//  Created by Sean Young on 2/18/22.
//

import Foundation

#if canImport(Combine)

import Combine

@available(iOS 13, macOS 10.15, *)
extension Publisher {
    
    /// Returns a new publisher that will receive any further events on the main queue.
    /// - Returns: A publisher.
    public func receiveOnMain() -> AnyPublisher<Output, Failure> {
        return receive(on: DispatchQueue.main, options: nil).eraseToAnyPublisher()
    }
}

#endif
