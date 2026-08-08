//
//  Author.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// The author of the RSS feed.
struct Author: Codable, Hashable, Identifiable, Sendable {
    let name: String?
    let url: String?

    var id: String {
        name ?? url ?? UUID().uuidString
    }

    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }

    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
    }

    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(url, forKey: .url)
    }

    enum CodingKeys: String, CodingKey {
        case name, url
    }
}
