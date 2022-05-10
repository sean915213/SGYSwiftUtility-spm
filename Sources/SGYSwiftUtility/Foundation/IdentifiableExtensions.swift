//
//  IdentifiableExtensions.swift
//  
//
//  Created by Sean Young on 5/10/22.
//

import Foundation

@available(iOS 13, macOS 10.15, *)
extension String: Identifiable {
    public var id: Int { hash }
}

@available(iOS 13, macOS 10.15, *)
extension RawRepresentable where RawValue: Identifiable {
    typealias ID = RawValue
    public var id: RawValue { rawValue }
}
