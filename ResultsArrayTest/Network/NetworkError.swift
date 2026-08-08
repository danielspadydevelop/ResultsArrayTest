//
//  NetworkError.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// Errors that can occur while fetching data from the network.
enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case decodingError(String)
    case transportError(String)

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse):
            return true
        case (.decodingError(let a), .decodingError(let b)),
             (.transportError(let a), .transportError(let b)):
            return a == b
        default:
            return false
        }
    }
}
