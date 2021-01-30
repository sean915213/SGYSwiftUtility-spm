//
//  ShellHandler.swift
//  mac-utils
//
//  Created by Sean G Young on 10/31/20.
//

#if canImport(AppKit)

import Foundation

protocol ShellHandler: AnyObject {
    func configureProcess(_ process: Process)
    func consumeFinishedProcess(_ process: Process)
}

#endif
