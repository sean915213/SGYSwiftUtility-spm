//
//  StringProtocolExtensions.swift
//
//
//  Created by Sean G Young on 2/7/20.
//

import Foundation

extension StringProtocol {

    /**
     Performs the decoding of the `StringProtocol` instance into data assuming it is in base64 URL-encoded format.
     
     - returns:
     A `Data` struct if decoding succeeded or `nil`.
     */
    public func base64URLDecode() -> Data? {
        var properBase64 = String(self)
        // Reverse URL encode to Foundation friendly base64
        properBase64 = properBase64.replacingOccurrences(of: "_", with: "/")
        properBase64 = properBase64.replacingOccurrences(of: "-", with: "+")
        // Re-add padding
        while properBase64.count % 4 != 0 { properBase64 += "=" }
        // Return string
        return Data(base64Encoded: properBase64)
    }
}
