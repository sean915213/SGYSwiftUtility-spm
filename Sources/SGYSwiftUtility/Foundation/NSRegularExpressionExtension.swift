//
//  NSRegularExpressionExtension.swift
//  
//
//  Created by Sean Young on 2/18/22.
//

import Foundation

extension NSRegularExpression {
    
    /// Possible numeric signs.
    public enum NumericSign { case none, negative, both }
    
    /// Creates a regular expression suitable for validating numeric input.
    /// - Parameters:
    ///   - sign: The type of `NumericSign` cases allowed.
    ///   - fractionalDigits: The number of valid fractional digits.
    /// - Returns: A regular expression.
    public static func numericValidation(forSign sign: NumericSign, fractionalDigits: Int?) -> NSRegularExpression {
        // Construct sign portion of regex
        let signRegex: String
        switch sign {
        case .none:
            // Unsigned means always positive, so sign portion is blank
            signRegex = ""
        case .negative:
            // Sign must be negative so require
            signRegex = "-"
        case .both:
            // Can be either, so make negative optional
            signRegex = "-?"
        }
        // If no digits use regex not allowing separator, either.
        let pattern: String
        if fractionalDigits == 0 {
            pattern = "^\(signRegex)\\d*$"
        } else {
            pattern = "^\(signRegex)\\d*\\\(NSLocale.current.decimalSeparator ?? ".")?\\d{0,\(fractionalDigits ?? 100)}$"
        }
        return try! NSRegularExpression(pattern: pattern, options: [])
    }
    
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
