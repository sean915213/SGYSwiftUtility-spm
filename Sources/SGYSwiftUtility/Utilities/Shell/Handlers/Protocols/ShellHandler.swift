//
//  ShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(AppKit)

import Foundation

public protocol ShellHandler: AnyObject {
    public func configureProcess(_ process: Process)
    public func consumeFinishedProcess(_ process: Process)
}

#endif
