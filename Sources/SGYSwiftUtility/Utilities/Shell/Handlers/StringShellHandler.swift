//
//  StringShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(macOS)

import Foundation

class StringShellHandler: DataShellHandlerProtocol {
    
    // MARK: - Initialization
    
    init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding
    }
    
    // MARK: - Properties
    
    let encoding: String.Encoding
    var output: String?
    
    // MARK: - Methods
    
    func transformData(_ data: Data) -> String? {
        return String(data: data, encoding: encoding)
    }
}

#endif
