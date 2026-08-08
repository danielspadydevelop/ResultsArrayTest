//
//  MockNetworkService.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// A test and preview double for `NetworkServiceProtocol`.
final class MockNetworkService: NetworkServiceProtocol {
    private let result: Result<Any, Error>

    init<T: Decodable & Sendable>(result: T) {
        self.result = .success(result)
    }

    init(error: Error) {
        self.result = .failure(error)
    }

    func fetch<T: Decodable & Sendable>(_ type: T.Type, from endpoint: Endpoint) async throws -> T {
        switch result {
        case .success(let value):
            guard let typed = value as? T else {
                throw NetworkError.decodingError("Mock returned an unexpected type.")
            }
            return typed
        case .failure(let error):
            throw error
        }
    }
}
