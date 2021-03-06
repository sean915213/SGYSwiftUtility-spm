//
//  MutedShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(AppKit)

import Foundation

public class MutedShellHandler: ShellHandler {
    
    public init() { }
    
    public func configureProcess(_ process: Process) {
        // Nil output so nothing is printed from executed
        process.standardOutput = nil
    }
    
    public func consumeFinishedProcess(_ process: Process) {
        // No result to consume
    }
}

#endif
