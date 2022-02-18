//
//  PublisherExtension.swift
//  
//
//  Created by Sean Young on 2/18/22.
//

import Foundation

#if canImport(Combine)

import Combine

@available(iOS 13, *)
extension Publisher {
    public func receiveOnMain() -> AnyPublisher<Output, Failure> {
        return receive(on: DispatchQueue.main, options: nil).eraseToAnyPublisher()
    }
}

#endif
