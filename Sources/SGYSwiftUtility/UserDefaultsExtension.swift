//
//  UserDefaultsExtension.swift
//  Pods
//
//  Created by Sean G Young on 2/13/16.
//
//

import Foundation

extension UserDefaults {
    
    /// Provides a method for retrieval and casting of UserDefaults values to type `T`.
    /// - Parameter defaultName: A key in the current user‘s defaults database.
    /// - Returns: An instance of `T` retrieved from this UserDefaults instance or `nil` if no object was found or could not be cast to `T`.
    public func object<T>(forKey defaultName: String) -> T? {
        return object(forKey: defaultName) as? T
    }
    
    /// Provides a method for retrieval and casting of UserDefaults values to a RawRepresentable type `T`.
    /// - Parameter defaultName: A key in the current user‘s defaults database.
    /// - Returns: An instance of `T` initialized from the raw value or `nil` if no value exists or cannot be used to initialize `T`.
    public func object<T>(forKey defaultName: String) -> T? where T: RawRepresentable {
        if let rawValue: T.RawValue = object(forKey: defaultName) { return T(rawValue: rawValue) }
        return nil
    }
    
    /// Stores a RawRepresentable value in UserDefaults.
    /// - Parameters:
    ///   - value: The RawRepresentable conforming value.
    ///   - defaultName: The key with which to associate the value.
    public func set<T>(_ value: T?, forKey defaultName: String) where T: RawRepresentable {
        set(value?.rawValue, forKey: defaultName)
    }
}
