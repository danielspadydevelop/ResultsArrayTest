//
//  FeedRepository.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// Concrete repository that loads the feed through the network service.
struct FeedRepository: FeedRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchTopFreeApps() async throws -> Feed {
        let root: RSSFeed = try await networkService.fetch(RSSFeed.self, from: .topFreeApps())
        guard let feed = root.feed else {
            throw NetworkError.decodingError("Missing feed object in response.")
        }
        return feed
    }
}
