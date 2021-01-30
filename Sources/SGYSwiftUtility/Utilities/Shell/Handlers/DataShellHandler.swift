//
//  DataShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(macOS)

import Foundation

class DataShellHandler: DataShellHandlerProtocol {
    
    // MARK: - Properties
    
    var output: Data?
    
    // MARK: - Methods
    
    func transformData(_ data: Data) -> Data? {
        return data
    }
}

#endif
