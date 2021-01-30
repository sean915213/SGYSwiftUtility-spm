//
//  DataShellHandlerProtocol.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(macOS)

import Foundation

protocol DataShellHandlerProtocol: ShellHandler {
    associatedtype Output
    
    var output: Output? { get set }
    
    func transformData(_ data: Data) -> Output?
}

extension DataShellHandlerProtocol {
    
    func configureProcess(_ process: Process) {
        // Create new pipe to gather output
        process.standardOutput = Pipe()
    }
    
    func consumeFinishedProcess(_ process: Process) {
        // Get resulting data
        let data = (process.standardOutput as! Pipe).fileHandleForReading.availableData
        // Shunt through protocol method to create proper type
        output = transformData(data)
    }
}

#endif
