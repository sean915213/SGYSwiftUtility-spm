//
//  LoggerExtension.swift
//  
//
//  Created by Sean Young on 8/28/22.
//

import Foundation
import os

@available(iOS 14, *)
extension Logger {
    
    static var subsystem = Bundle.main.bundleIdentifier ?? ""
    
    init(category: String) {
        self.init(subsystem: type(of: self).subsystem, category: category)
    }
}

@available(iOS 14, *)
extension Logger {
    struct Category: RawRepresentable {
        var rawValue: String
    }
    
    init(category: Category) {
        self.init(subsystem: type(of: self).subsystem, category: category.rawValue)
    }
}
