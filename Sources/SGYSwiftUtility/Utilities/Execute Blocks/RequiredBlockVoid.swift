//
//  RequiredBlockVoid.swift
//  JarusPnCApp
//
//  Created by Sean Young on 9/3/21.
//  Copyright © 2021 Jarus Technologies. All rights reserved.
//

import Foundation

/// A version of `RequiredBlockParam` that takes no arguments (i.e. a `Void` argument)
class RequiredBlockVoid<Return>: RequiredBlockParam<Void, Return> {
    
    /// Invokes the contained block requiring no arguments with an optional return value.
    /// - Returns: The `Return` type.
    func callAsFunction() -> Return {
        super.callAsFunction(())
    }
}
