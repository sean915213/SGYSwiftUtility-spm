//
//  PublisherExtensions.swift
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

@available(iOS 13, macOS 10.15, *)
extension Publisher where Output: BidirectionalCollection {
    
    private typealias AnyBD = AnyBidirectionalCollection<Output.Element>
    
    /// Returns a new publisher that emits  the `CollectionDifference` resulting from the last two emitted collections.
    /// - Returns: The collection difference from the last two emitted collections.
    public func difference() -> AnyPublisher<CollectionDifference<Output.Element>, Failure> where Output.Element: Equatable {
        return scan((AnyBD([]), AnyBD([]))) { prev, new in
            // Collect last 2 values
            (prev.1, AnyBD(new))
        }.map { values in
            // Return diff
            values.1.difference(from: values.0)
        }.eraseToAnyPublisher()
    }
}

#endif
