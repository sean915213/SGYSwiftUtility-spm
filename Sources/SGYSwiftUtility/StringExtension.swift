//
//  StringExtension.swift
//  
//
//  Created by Sean G Young on 2/9/20.
//

import Foundation

extension String {
    
    /**
     Returns a string from removing the characters present in the provided `CharacterSet`.
     
     - parameters:
        - characterSet: The `CharacterSet` containing the characters to be removed.
     
     - returns:
     A new string with the provided characters removed.``
     */
    public func stringRemovingCharacters(inSet characterSet: CharacterSet) -> String {
        // Construct new string from scalars
        let newScalars = unicodeScalars.filter({ !characterSet.contains($0) })
        return String(String.UnicodeScalarView(newScalars))
    }
    
    /**
     Mutates the string by removing the characters present in the provided `CharacterSet`.
     
     - parameters:
        - characterSet: The `CharacterSet` containing the characters to be removed.
     */
    public mutating func removeCharacters(inSet characterSet: CharacterSet) {
        self = stringRemovingCharacters(inSet: characterSet)
    }
}
