//
//  ProcessInfoExtension.swift
//  
//
//  Created by Sean Young on 5/29/22.
//

import Foundation

extension ProcessInfo {
    
    /// A type-safe struct for representing options arguments that could be set in the currently running scheme.
    public struct Argument: RawRepresentable {
        init(rawValue: String) { self.rawValue = rawValue }
        let rawValue: String
    }
    
    /// A convenience method for searching the current process's arguments list for a defined `Argument`.
    ///
    /// - Parameter argument: The argument to search for.
    /// - Returns: Whether the current process's arguments list includes this argument.
    public func hasArgument(_ argument: Argument) -> Bool {
        return arguments.contains(argument.rawValue)
    }
}
