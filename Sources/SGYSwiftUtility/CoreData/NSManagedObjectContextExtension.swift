//
//  NSManagedObjectContextExtension.swift
//  SGYSwiftUtility
//
//  Created by Sean G Young on 11/3/18.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    public func existingObject<T: NSManagedObject>(with objectID: NSManagedObjectID) throws -> T {
        // Force cast since object not found will throw and if an object is found of the wrong type the caller messed up.
        return try existingObject(with: objectID) as! T
    }
}
