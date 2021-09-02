//
//  URLExtension.swift
//  
//
//  Created by Sean Young on 9/2/21.
//

import Foundation

// MARK: General

extension URL {
    
    /// Whether the URL has an http/s scheme.
    var hasHTTPScheme: Bool {
        return scheme?.lowercased().hasPrefix("http") == true
    }
    
    /// Returns the last path component without the extension, if any.
    var lastPathComponentWithoutExtension: String {
        return deletingPathExtension().lastPathComponent
    }
}

// MARK: Security/Bookmark

extension URL {
    
    typealias ResolvedBookmark = (url: URL, isStale: Bool)
    
    /// Custom extension for identifying files representing bookmark data
    static var bookmarkDataExtension: String { "bmk" }
    
    /// Accesses the URL as a security scoped resource for logic within the handler. Automatically relinquishes security access (if granted) after handler is completed.
    /// - Parameter handler: The handler to execute requiring security access scope.
    /// - Throws: Any uncaught errors encountered inside handler.
    /// - Returns: The `Value` returned from the handler.
    func accessAsSecurityScopedResource<Value>(handler: (URL) throws -> Value) rethrows -> Value {
        let accessing = startAccessingSecurityScopedResource()
        defer { if accessing { stopAccessingSecurityScopedResource() } }
        return try handler(self)
    }
    
    /// Accesses the URL as a security scoped resource for logic within the handler. Relinquishes security access (if granted) when completion block is called.
    /// - Parameter handler: The handler to execute requiring security access scope with asynchronous functionality.
    /// - Throws: Any uncaught errors encountered inside handler.
    func accessAsSecurityScopedResource(handler: (URL, @escaping () -> Void) throws -> Void) rethrows {
        let accessing = startAccessingSecurityScopedResource()
        try handler(self) {
            if accessing { stopAccessingSecurityScopedResource() }
        }
    }
    
    /// Writes the receiver as a bookmark data stored at the provided URL. Automatically performs logic within security scoped access.
    /// - Parameters:
    ///   - fileURL: The URL to write the bookmark data to.
    ///   - options: Bookmark creation options.
    ///   - resourceValuesForKeys: A set of resource value keys.
    ///   - writingOptions: Data writing options.
    /// - Throws: Any errors encountered during the process.
    func makeBookmarkFile(at fileURL: URL, options: BookmarkCreationOptions = [], includingResourceValuesForKeys resourceValuesForKeys: Set<URLResourceKey>? = nil, writingOptions: Data.WritingOptions = []) throws {
        try accessAsSecurityScopedResource { url in
            let data = try url.bookmarkData(options: options, includingResourceValuesForKeys: resourceValuesForKeys, relativeTo: nil)
            try data.write(to: fileURL, options: writingOptions)
        }
    }
    
    /// Resolves the receiver as bookmark data. Automatically performs logic within security scoped access.
    /// - Parameter options: Bookmark resolution options.
    /// - Throws: Any errors encountered during the process.
    /// - Returns: A struct with the resolved URL and whether it is stale.
    func resolveAsBookmark(options: BookmarkResolutionOptions = []) throws -> ResolvedBookmark {
        return try accessAsSecurityScopedResource { url in
            // Read data from bookmark URL
            let data = try Data(contentsOf: url)
            // Resolve bookmark
            var stale = false
            let resolvedUrl = try URL(resolvingBookmarkData: data, options: [], relativeTo: nil, bookmarkDataIsStale: &stale)
            return (resolvedUrl, stale)
        }
    }
    
    /// Returns the URL pointed to by this bookmark, or the receiver if it's not a bookmark.
    /// - Parameter options: Optional bookmark resolution options.
    /// - Throws: Errors encountered resolving as a bookmark.
    /// - Returns: The resolved bookmark or original receiver.
    func resolveFollowingBookmark(options: BookmarkResolutionOptions = []) throws -> URL {
        // If not bookmark extension then return self
        guard pathExtension == URL.bookmarkDataExtension else { return self }
        // Otherwise return as resolved bookmark
        return try resolveAsBookmark(options: options).url
    }
}
