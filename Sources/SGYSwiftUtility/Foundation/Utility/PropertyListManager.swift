//
//  PropertyListManager.swift
//  
//
//  Created by Sean Young on 7/9/22.
//

import Foundation

private let plistCache = NSCache<NSString, ValueWrapper>()
private let decoder = PropertyListDecoder()

extension PropertyListManager.Name {
    public static let info = PropertyListManager.Name(rawValue: "Info")
}

public enum PropertyListManager {
    
    public struct Name: RawRepresentable {
        public init(rawValue: String) { self.rawValue = rawValue }
        public let rawValue: String
    }
    
    public enum Error: Swift.Error { case invalidName }
    
    public static func objectFromList<T>(named name: Name) throws -> T where T: Decodable {
        // Attempt pulling from cache
        if let cached = plistCache.object(forKey: name.rawValue as NSString)?.value as? T { return cached }
        // Otherwise read data and decode
        let data = try dataFromList(named: name)
        let value = try decoder.decode(T.self, from: data)
        // Store in cache and return
        plistCache.setObject(ValueWrapper(value: value), forKey: name.rawValue as NSString)
        return value
    }
    
    public static func dictionaryFromList(named name: Name) throws -> [String: Any] {
        // Attempt pulling from cache
        if let cached = plistCache.object(forKey: name.rawValue as NSString)?.value as? [String: Any] { return cached }
        // Otherwise read data and decode
        let data = try dataFromList(named: name)
        let dictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String: Any]
        // Store in cache and return
        plistCache.setObject(ValueWrapper(value: dictionary), forKey: name.rawValue as NSString)
        return dictionary
    }
    
    private static func dataFromList(named name: Name) throws -> Data {
        guard let url = Bundle.main.url(forResource: name.rawValue, withExtension: "plist") else { throw Error.invalidName }
        return try Data(contentsOf: url)
    }
}
