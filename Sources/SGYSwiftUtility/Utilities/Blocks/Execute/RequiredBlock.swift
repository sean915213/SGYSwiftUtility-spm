//
//  RequiredBlock.swift
//  JarusPnCApp
//
//  Created by Sean Young on 9/3/21.
//  Copyright © 2021 Jarus Technologies. All rights reserved.
//

import Foundation

/// A class that can be executed as a block, allowing it to detect when it has gone out of scope without being executed and raising an assertion if so.
class RequiredBlock<Param, Return> {
    
    typealias Block = (Param) -> Return
    
    // MARK: - Initialization
    
    /// Initializes the class with a required block to execute and optional failure messages.
    /// - Parameters:
    ///   - block: The block which must be executed before the class goes out of scope.
    ///   - failureMessage: The failure message to display in the assertion if the block is not executed before going out of scope.
    init(block: @escaping Block, failureMessage: String = "Block must be executed before leaving scope. This is a programming error.") {
        self.block = block
        self.failureMessage = failureMessage
    }
    
    deinit {
        assert(didCall, failureMessage)
    }
    
    // MARK: - Properties
    
    private let block: Block
    private let failureMessage: String
    private var didCall = false
    
    // MARK: - Methods
    
    /// Executes the block the instances contains.
    /// - Parameter param: The parameter type expected by the block.
    /// - Returns: The return type expected by the block.
    @discardableResult func callAsFunction(_ param: Param) -> Return {
        didCall = true
        return block(param)
    }
}

extension RequiredBlock where Param == Void {
    /// Executes the block the instance contains.
    /// - Returns: The return type expected by the block.
    @discardableResult func callAsFunction() -> Return {
        callAsFunction(())
    }
}
