//
//  ConsoleShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(macOS)

import Foundation

final class ConsoleShellHandler: ShellHandler {
    
    func configureProcess(_ process: Process) {
        // Assign standard (i.e. console) output
        process.standardOutput = FileHandle.standardOutput
    }
    
    func consumeFinishedProcess(_ process: Process) {
        // Nothing to do as output is shunted to console
    }
}

#endif
