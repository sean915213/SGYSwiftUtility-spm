//
//  MaskingFormatter.swift
//  
//
//  Created by Sean Young on 1/14/22.
//

import Foundation

/// Formats a string into a masked version.
public class MaskingFormatter: Formatter {
    
    // MARK: - Properties
    
    /// The string that acts as the mask for a masked character.
    public var maskingCharacter: Unicode.Scalar = "*"
    /// The set of characters that should be masked.
    public var maskedCharacters = CharacterSet()
    /// The maximum number of characters to mask. If `nil`all characters will be masked.
    public var maximumMaskCount: Int?
    
    // MARK: - Methods
    
    override public func string(for obj: Any?) -> String? {
        // Require string to format
        guard let stringVal = obj as? String else { return nil }
        // Add masking character to set so we also skip
        // Create masked version
        var masked = ""
        var maskedCount = 0
        for nextChar in stringVal.unicodeScalars {
            // If not in masked characters AND isn't the masking character itself then skip altogether
            guard maskedCharacters.contains(nextChar) || nextChar == maskingCharacter else {
                masked.unicodeScalars.append(nextChar)
                continue
            }
            // If didn't reach masked count then mask
            if maximumMaskCount == nil || maskedCount < maximumMaskCount! {
                masked.unicodeScalars.append(maskingCharacter)
                maskedCount += 1
            } else {
                // Unmasked value
                masked.unicodeScalars.append(nextChar)
            }
        }
        // Return masked string
        return masked
    }
}
