//
//  ValueWrapper.swift
//  
//
//  Created by Sean Young on 7/9/22.
//

import Foundation

/// Class designed to wrap value types for tasks that require `AnyObject`.
public class ValueWrapper {
    public init(value: Any) { self.value = value }
    public let value: Any
}
