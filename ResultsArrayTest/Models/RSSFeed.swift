//
//  RSSFeed.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// Top-level container returned by the Apple RSS feed endpoint.
struct RSSFeed: Codable, Sendable {
    let feed: Feed?

    init(feed: Feed?) {
        self.feed = feed
    }

    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        feed = try container.decodeIfPresent(Feed.self, forKey: .feed)
    }

    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(feed, forKey: .feed)
    }

    enum CodingKeys: String, CodingKey {
        case feed
    }
}
