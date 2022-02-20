//
//  AsyncResultOperation.swift
//  
//
//  Created by Sean Young on 2/20/22.
//

import Foundation

#if canImport(Combine)

import Combine

@available(iOS 13, *)
open class AsyncResultOperation<ResultType>: AsyncOperation {
    
    // MARK: - Initialization
    
    // MARK: - Properties
    
    public private(set) var result: Result<ResultType, Error>?
    
    public private(set) lazy var publisher: AnyPublisher<ResultType, Error> = {
        return Future<ResultType, Error> { [unowned self] promise in
            pendingPromise = promise
        }.eraseToAnyPublisher()
    }()
    
    private var pendingPromise: Future<ResultType, Error>.Promise?
    
    // MARK: - Methods
    
    open func endExecution(with result: Result<ResultType, Error>) {
        self.result = result
        // Finish
        endExecution()
        // Invoke promise if any
        switch result {
        case .success(let result): pendingPromise?(.success(result))
        case .failure(let error): pendingPromise?(.failure(error))
        }
    }
    
    override open func endExecution() {
        assert(!(!isCancelled && result == nil), "Result must be assigned before ending execution")
        super.endExecution()
    }
}

#endif
