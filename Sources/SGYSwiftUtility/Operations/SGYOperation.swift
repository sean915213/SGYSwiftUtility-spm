//
//  SGYOperation.swift
//  Pods
//
//  Created by Sean G Young on 4/23/16.
//
//

import Foundation

open class SGYOperation: Operation {
    
    // MARK: - Properties
    
    open lazy var logger = Logger(source: type(of: self))
}
