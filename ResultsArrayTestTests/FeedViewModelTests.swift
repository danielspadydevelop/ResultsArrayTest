//
//  FeedViewModelTests.swift
//  ResultsArrayTestTests
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation
import Testing
@testable import ResultsArrayTest

@MainActor
struct FeedViewModelTests {

    @Test func loadFeedPopulatesFeedOnSuccess() async {
        let expectedFeed = Feed(
            title: "Top Free Apps",
            id: "feed-id",
            author: nil,
            links: nil,
            copyright: nil,
            country: nil,
            icon: nil,
            updated: nil,
            results: [
                AppResult(
                    artistName: "Test Artist",
                    appStoreId: "123",
                    name: "Test App",
                    releaseDate: nil,
                    kind: nil,
                    artworkUrl100: nil,
                    genres: nil,
                    url: nil
                )
            ]
        )
        let mockService = MockNetworkService(result: RSSFeed(feed: expectedFeed))
        let repository = FeedRepository(networkService: mockService)
        let viewModel = FeedViewModel(repository: repository)

        await viewModel.loadFeed()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.feed?.title == expectedFeed.title)
        #expect(viewModel.feed?.results?.count == 1)
    }

    @Test func loadFeedSetsErrorMessageOnFailure() async {
        let mockService = MockNetworkService(error: NetworkError.invalidURL)
        let repository = FeedRepository(networkService: mockService)
        let viewModel = FeedViewModel(repository: repository)

        await viewModel.loadFeed()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.feed == nil)
        #expect(viewModel.errorMessage != nil)
    }
}
