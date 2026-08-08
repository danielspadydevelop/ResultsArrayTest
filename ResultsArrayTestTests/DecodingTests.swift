//
//  DecodingTests.swift
//  ResultsArrayTestTests
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation
import Testing
@testable import ResultsArrayTest

struct DecodingTests {

    @Test func decodesLocalJSONFixture() throws {
        let data = try loadJSONData()
        let root = try JSONDecoder().decode(RSSFeed.self, from: data)

        let feed = try #require(root.feed)
        #expect(feed.title == "Top Free Apps")
        #expect(feed.country == "us")
        #expect(feed.author?.name == "Apple")
        #expect(feed.results?.count == 50)
    }

    @Test func decodesFirstAppResult() throws {
        let data = try loadJSONData()
        let root = try JSONDecoder().decode(RSSFeed.self, from: data)

        let firstApp = try #require(root.feed?.results?.first)
        #expect(firstApp.artistName == "TikTok Ltd.")
        #expect(firstApp.appStoreId == "6741796873")
        #expect(firstApp.name == "TikTok Pro - Events")
        #expect(firstApp.kind == "apps")
    }

    @Test func decodesGenreObjects() throws {
        let data = try loadJSONData()
        let root = try JSONDecoder().decode(RSSFeed.self, from: data)

        let appWithGenres = try #require(root.feed?.results?.first(where: { ($0.genres?.count ?? 0) > 0 }))
        let firstGenre = try #require(appWithGenres.genres?.first)
        #expect(firstGenre.genreId != nil)
        #expect(firstGenre.name != nil)
        #expect(firstGenre.url != nil)
    }

    private func loadJSONData() throws -> Data {
        let bundle = Bundle(for: MockNetworkService.self)
        guard let url = bundle.url(forResource: "ResultJSON", withExtension: "json") else {
            throw TestError("Could not find ResultJSON.json in bundle.")
        }
        return try Data(contentsOf: url)
    }
}

private struct TestError: Error {
    let message: String
    init(_ message: String) { self.message = message }
}
