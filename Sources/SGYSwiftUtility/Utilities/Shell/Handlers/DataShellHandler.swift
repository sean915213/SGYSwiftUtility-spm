//
//  DataShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(AppKit)

import Foundation

public class DataShellHandler: DataShellHandlerProtocol {
    
    // MARK: - Properties
    
    public var output: Data?
    
    // MARK: - Methods
    
    public func transformData(_ data: Data) -> Data? {
        return data
    }
}

#endif
