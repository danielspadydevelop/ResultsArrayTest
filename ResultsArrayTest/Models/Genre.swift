//
//  Genre.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// A genre classification attached to an app result.
struct Genre: Codable, Hashable, Identifiable, Sendable {
    let genreId: String?
    let name: String?
    let url: String?

    var id: String {
        genreId ?? name ?? UUID().uuidString
    }

    init(genreId: String?, name: String?, url: String?) {
        self.genreId = genreId
        self.name = name
        self.url = url
    }

    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genreId = try container.decodeIfPresent(String.self, forKey: .genreId)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
    }

    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(genreId, forKey: .genreId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(url, forKey: .url)
    }

    enum CodingKeys: String, CodingKey {
        case genreId, name, url
    }
}
