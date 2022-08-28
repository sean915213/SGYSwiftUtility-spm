//
//  LogStreamer.swift
//  Plot Notes
//
//  Created by Sean Young on 8/27/22.
//

import Foundation
import os
import OSLog
import Combine

@available(iOS 15, *)
public class LogStreamer {

    // MARK: - Initialization
    
    public init(categories: [String]) throws {
        logCategories = categories
        // Attempt creating log store
        logStore = try OSLogStore(scope: .currentProcessIdentifier)
        setup()
    }
    
    // MARK: - Properties
    
    public let logCategories: [String]
    public private(set) var entries = [OSLogEntry]()
    
    private let logStore: OSLogStore
    private let queue = DispatchQueue(label: "com.sdot.logStreamer", qos: .utility)
    
    private lazy var logger = Logger(category: String(describing: type(of: self)))
    
    private let entriesSubject = PassthroughSubject<[OSLogEntry], Never>()
    public private(set) lazy var publisher = entriesSubject.eraseToAnyPublisher()
    
    // MARK: - Methods
    
    private func setup() {
        // Fetch latest entries
        queue.async { self.fetchNewEntries() }
    }
    
    private func fetchNewEntries() {
        // Fetch entries
        do {
            // Determine date to query from by getting last entry and adding small amount of time
            let checkDate = entries.last?.date ?? Date(timeIntervalSince1970: 0)
            let newEntries = try logStore.getEntries(with: [], at: logStore.position(timeIntervalSinceLatestBoot: 0), matching: NSPredicate(format: "category IN %@ AND date > %@", logCategories, checkDate as CVarArg))
            digestEntries(newEntries)
        } catch {
            logger.error("Failed fetching log entries w/ error: \(error.localizedDescription, privacy: .public)")
        }
        // Schedule next run
        queue.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            self?.fetchNewEntries()
        })
    }
    
    private func digestEntries(_ newEntries: AnySequence<OSLogEntry>) {
        let entriesArray = Array(newEntries)
        guard !entriesArray.isEmpty else { return }
        // Add to total and notify subscribers
        entries.append(contentsOf: entriesArray)
        entriesSubject.send(entriesArray)
    }
}

@available(iOS 15, *)
extension LogStreamer {
    public convenience init(categories: [Logger.Category]) throws {
        try self.init(categories: categories.map { $0.rawValue })
    }
}
