//
//  UIResponderExtension.swift
//  
//
//  Created by Sean Young on 5/9/22.
//

#if canImport(UIKit)

import UIKit

extension UIResponder {
    
    /// An ordered sequence of the chain of next responders.
    public var responderChain: ResponderChain { ResponderChain(self) }
    
    /// Finds the next responder of type `T` in the chain.
    ///
    /// - Parameter ofType: The type to search for.
    /// - Parameter allowSelf: Whether the search can return this instance of must begin with the next responder. Defaults to `false`.
    /// - Returns: The next responder of type `T` or `nil`.
    public func findNextResponder<T>(ofType: T.Type, allowSelf: Bool = false) -> T? {
        for responder in responderChain {
            if responder == self && !allowSelf { continue }
            if responder is T { return responder as? T }
        }
        return nil
    }
}

/// A sequence representing a chain of responders.
public struct ResponderChain: Sequence {
    
    /// An iterator that walks a chain of responders.
    public struct ResponderChainIterator: IteratorProtocol {
        
        public var currentResponder: UIResponder?
        
        public mutating func next() -> UIResponder? {
            defer { currentResponder = currentResponder?.next }
            return currentResponder
        }
    }
    
    /// Initializes the sequence representing a chain of next responders beginning at a root.
    /// - Parameter first: The responder that begins the sequence.
    public init(_ first: UIResponder) {
        self.first = first
    }
    
    /// The first responder in the chain.
    public let first: UIResponder
    
    public func makeIterator() -> ResponderChainIterator {
        ResponderChainIterator(currentResponder: first)
    }
}

#endif
