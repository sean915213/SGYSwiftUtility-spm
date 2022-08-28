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
    
    public static var subsystem = Bundle.main.bundleIdentifier ?? ""
    
    public init(category: String) {
        self.init(subsystem: type(of: self).subsystem, category: category)
    }
}

@available(iOS 14, *)
extension Logger {
    public struct Category: RawRepresentable {
        public init?(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public var rawValue: String
    }
    
    public init(category: Category) {
        self.init(subsystem: type(of: self).subsystem, category: category.rawValue)
    }
}
