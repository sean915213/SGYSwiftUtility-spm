//
//  NSFetchedResultsChangeTypeExtension.swift
//  Pods-SGYSwiftUtility_Tests
//
//  Created by Sean G Young on 8/19/18.
//

import Foundation
import CoreData

extension NSFetchedResultsChangeType: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .delete: return "Delete"
        case .insert: return "Insert"
        case .move: return "Move"
        case .update: return "Update"
        @unknown default: return "Unknown"
        }
    }
}
