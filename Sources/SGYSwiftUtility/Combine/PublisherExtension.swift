//
//  PublisherExtension.swift
//  
//
//  Created by Sean Young on 2/18/22.
//

import Foundation
import Combine

extension Publisher {
    func receiveOnMain() -> AnyPublisher {
        return receive(on: DispatchQueue.main, options: nil).eraseToAnyPublisher()
    }
}
