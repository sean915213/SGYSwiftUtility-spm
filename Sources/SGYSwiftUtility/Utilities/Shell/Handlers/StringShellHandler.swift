//
//  StringShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(macOS)

import Foundation

public class StringShellHandler: DataShellHandlerProtocol {
    
    // MARK: - Initialization
    
    public init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding
    }
    
    // MARK: - Properties
    
    public let encoding: String.Encoding
    public var output: String?
    
    // MARK: - Methods
    
    public func transformData(_ data: Data) -> String? {
        return String(data: data, encoding: encoding)
    }
}

#endif
