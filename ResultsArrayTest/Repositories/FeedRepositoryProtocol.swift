//
//  FeedRepositoryProtocol.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// Repository boundary for fetching the top-free-apps feed.
protocol FeedRepositoryProtocol: Sendable {
    func fetchTopFreeApps() async throws -> Feed
}
