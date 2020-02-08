//
//  DataExtension.swift
//
//  Created by Sean G Young on 8/2/16.
//

import Foundation

extension Data {
    
    public init?(hexString string: String) {
        // Make sure this string CAN be converted (ie. has even number of characters)
        guard !string.isEmpty && string.lengthOfBytes(using: String.Encoding.utf8) % 2 == 0 else { return nil }
        // Array to store bytes
        var byteArray = [UInt8]()
        // Grab the bytes from the string in 2 character chunks
        var index = string.startIndex
        repeat {
            let byteString = string[index..<string.index(index, offsetBy: 2)]
            // Convert to UInt8 representation of the C string
            let num = UInt8(byteString.withCString { strtoul($0, nil, 16) })
            // Append to array
            byteArray.append(num)
            // Increment index by 2 spaces
            index = string.index(index, offsetBy: 2)
        } while index < string.endIndex
        // Initialize
        self.init(byteArray)
    }
    
    public func hexString() -> String? {
        guard !isEmpty else { return nil }
        var hexString = String()
        // Append to string
        for byte in self { hexString += String(format: "%02x", UInt(byte)) }
        return hexString
    }
}

// MARK: Write Operations
extension Data {
    
    private static let sanitizedCharacters = ["/", " "]
    
    /// Writes the provided data to a file in the temp directory.
    ///
    /// - Parameters:
    ///   - name: The name for the file.
    ///   - extension: The optional extension for the file.
    /// - Returns: A `URL` instance pointing to the written file.
    /// - Throws: Any errors thrown by `FileManager` in the process of creating the temp directory and writing the file.
    public func writeToTempFile(withName name: String, extension: String?) throws -> URL {
        let fileManager = FileManager.default
        // Create unique directory inside temp folder
        let containingDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ProcessInfo.processInfo.globallyUniqueString)
        try fileManager.createDirectory(at: containingDirectory, withIntermediateDirectories: false, attributes: nil)
        // Sanitize file's name
        var fileName = name
        Data.sanitizedCharacters.forEach { fileName = fileName.replacingOccurrences(of: $0, with: "") }
        // Create url in this directory
        var dataUrl = containingDirectory.appendingPathComponent(fileName)
        if let `extension` = `extension` { dataUrl = dataUrl.appendingPathExtension(`extension`) }
        // Finally write data
        try write(to: dataUrl)
        // Return url
        return dataUrl
    }
}
