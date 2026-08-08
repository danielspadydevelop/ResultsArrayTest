//
//  FeedLink.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// A link object returned inside the feed's `links` array.
struct FeedLink: Codable, Hashable, Identifiable, Sendable {
    let urlString: String?

    var id: String {
        urlString ?? UUID().uuidString
    }

    init(urlString: String?) {
        self.urlString = urlString
    }

    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        urlString = try container.decodeIfPresent(String.self, forKey: .urlString)
    }

    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(urlString, forKey: .urlString)
    }

    enum CodingKeys: String, CodingKey {
        case urlString = "self"
    }
}
