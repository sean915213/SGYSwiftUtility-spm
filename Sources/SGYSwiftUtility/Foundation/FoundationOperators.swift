//
//  FoundationOperators.swift
//  
//
//  Created by Sean Young on 2/18/22.
//

import Foundation

// MARK: Null assignment
infix operator ?=
public func ?=<T>(left: inout T?, right: T) {
    left = left == nil ? right : left
}
