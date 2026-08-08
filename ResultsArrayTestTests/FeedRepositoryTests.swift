//
//  FeedRepositoryTests.swift
//  ResultsArrayTestTests
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation
import Testing
@testable import ResultsArrayTest

@MainActor
struct FeedRepositoryTests {

    @Test func fetchTopFreeAppsReturnsFeed() async throws {
        let expectedFeed = Feed(
            title: "Top Free Apps",
            id: "feed-id",
            author: Author(name: "Apple", url: "https://www.apple.com/"),
            links: [],
            copyright: nil,
            country: "us",
            icon: nil,
            updated: nil,
            results: []
        )
        let mockService = MockNetworkService(result: RSSFeed(feed: expectedFeed))
        let repository = FeedRepository(networkService: mockService)

        let feed = try await repository.fetchTopFreeApps()

        #expect(feed.title == expectedFeed.title)
        #expect(feed.author?.name == expectedFeed.author?.name)
    }

    @Test func fetchTopFreeAppsThrowsWhenFeedMissing() async throws {
        let mockService = MockNetworkService(result: RSSFeed(feed: nil))
        let repository = FeedRepository(networkService: mockService)

        await #expect(throws: NetworkError.self) {
            _ = try await repository.fetchTopFreeApps()
        }
    }

    @Test func fetchTopFreeAppsPropagatesNetworkErrors() async throws {
        let mockService = MockNetworkService(error: NetworkError.invalidURL)
        let repository = FeedRepository(networkService: mockService)

        await #expect(throws: NetworkError.invalidURL) {
            _ = try await repository.fetchTopFreeApps()
        }
    }
}
