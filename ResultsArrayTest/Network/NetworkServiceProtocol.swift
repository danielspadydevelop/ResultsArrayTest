//
//  NetworkServiceProtocol.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// The network boundary. Conforming types can fetch and decode remote JSON.
protocol NetworkServiceProtocol: Sendable {
    /// Fetches data from the supplied endpoint and decodes it into `T`.
    /// - Parameters:
    ///   - type: The expected `Decodable` type.
    ///   - endpoint: The endpoint to request.
    /// - Returns: The decoded value.
    func fetch<T: Decodable & Sendable>(_ type: T.Type, from endpoint: Endpoint) async throws -> T
}
