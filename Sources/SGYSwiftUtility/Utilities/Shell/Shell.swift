//
//  Shell.swift
//  MacUtils
//
//  Created by Sean G Young on 10/20/20.
//

#if canImport(macOS)

import Foundation

enum Shell {
    
    static var phpPath = URL(fileURLWithPath: "/usr/bin/php")
    
    @discardableResult
    static func execute(launchURL: URL, arguments: [String], handler: ShellHandler) throws -> Int {
        // Create task
        let task = Process()
        task.executableURL = launchURL
        task.arguments = arguments
        // Allow handler to configure the process further
        handler.configureProcess(task)
        // Run and await completion
        try task.run()
        task.waitUntilExit()
        // Allow handler to consume result
        handler.consumeFinishedProcess(task)
        // Return status
        return Int(task.terminationStatus)
    }
    
    @discardableResult
    static func executePHP(code: String, arguments: [String], handler: ShellHandler = ConsoleShellHandler()) throws -> Int {
        let args = ["-r", code] + arguments
        return try execute(launchURL: phpPath, arguments: args, handler: handler)
    }
}

#endif
