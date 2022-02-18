//
//  NSRegularExpressionExtension.swift
//  
//
//  Created by Sean Young on 2/18/22.
//

import Foundation

extension NSRegularExpression {
    
    /// Finds the first match within the entire string.
    /// - Parameters:
    ///   - string: The string to match against.
    ///   - options: Regular expression options.
    /// - Returns: The first match as an `NSTextCheckingResult` or `nil` if no matches.
    public func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = []) -> NSTextCheckingResult? {
        return firstMatch(in: string, options: options, range: NSRange(string.startIndex..., in: string))
    }
    
    /// Returns whether at least one match occurs in the entire string.
    /// - Parameters:
    ///   - string: The string to match against.
    ///   - options: Regular expression options.
    /// - Returns: Whether at least one match occurs.
    public func anyMatches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> Bool {
        return firstMatch(in: string, options: options) != nil
    }
}
