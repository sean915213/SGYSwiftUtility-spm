//
//  MutedShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(macOS)

import Foundation

class MutedShellHandler: ShellHandler {
    
    func configureProcess(_ process: Process) {
        // Nil output so nothing is printed from executed
        process.standardOutput = nil
    }
    
    func consumeFinishedProcess(_ process: Process) {
        // No result to consume
    }
}

#endif
