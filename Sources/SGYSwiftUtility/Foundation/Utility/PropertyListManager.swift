//
//  PropertyListManager.swift
//  
//
//  Created by Sean Young on 7/9/22.
//

import Foundation

private let plistCache = NSCache<NSString, NSData>()
private let decoder = PropertyListDecoder()

extension PropertyListManager.Name {
    /// The Info.plist
    public static let info = PropertyListManager.Name(rawValue: "Info")
}

/// Handles caching and decoding of plists.
public enum PropertyListManager {
    
    /// A type-safe string value representing the name of a plist to load.
    public struct Name: RawRepresentable {
        public init(rawValue: String) { self.rawValue = rawValue }
        public let rawValue: String
    }
    
    /// Describes errors thrown by this type.
    public enum Error: Swift.Error { case invalidName }
    
    /// Loads the provided plist and converts to type `T`.
    /// - Parameters:
    ///   - name: The plist name.
    ///   - type: The type to decode the plist into.
    ///   - bundle: The bundle to load the plist from. Defaults to `main`.
    /// - Returns: The plist decoded to type `T`.
    public static func objectFromList<T>(named name: Name, ofType type: T.Type, from bundle: Bundle = Bundle.main) throws -> T where T: Decodable {
        // Read data and decode
        let data = try dataFromList(named: name, from: bundle)
        return try decoder.decode(T.self, from: data)
    }
    
    /// Loads the provided plist as a dictionary.
    /// - Parameters:
    ///   - name: The plist name.
    ///   - bundle: The bundle to load the plist from. Defaults to `main`.
    /// - Returns: The plist decoded as a dictionary.
    public static func dictionaryFromList(named name: Name, from bundle: Bundle = Bundle.main) throws -> [String: Any] {
        // Read data and decode
        let data = try dataFromList(named: name, from: bundle)
        return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String: Any]
    }
    
    private static func dataFromList(named name: Name, from bundle: Bundle) throws -> Data {
        // Attempt pulling from cache
        if let cached = plistCache.object(forKey: name.rawValue as NSString) { return cached as Data }
        // Otherwise load from disk
        guard let url = bundle.url(forResource: name.rawValue, withExtension: "plist") else { throw Error.invalidName }
        let data = try Data(contentsOf: url)
        // Assign to cache before returning
        plistCache.setObject(data as NSData, forKey: name.rawValue as NSString)
        return data
    }
}
