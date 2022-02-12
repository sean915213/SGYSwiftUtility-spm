//
//  AutoCleanupBlock.swift
//  JarusPnCApp
//
//  Created by Sean Young on 9/7/21.
//  Copyright © 2021 Jarus Technologies. All rights reserved.
//

import Foundation

/// A class that executes a block on deinitialization
class AutoCleanupBlock {
    
    // MARK: - Initialization
    
    /// Initializes the receiver with a cleanup block.
    /// - Parameter cleanup: The block to execute on deinitialization.
    init(cleanup: @escaping () -> Void) {
        self.cleanup = cleanup
    }
    
    deinit { cleanup() }
    
    // MARK: - Properties
    
    private let cleanup: () -> Void
}
