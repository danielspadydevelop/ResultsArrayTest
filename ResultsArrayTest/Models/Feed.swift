//
//  Feed.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// Metadata describing the RSS feed and the list of apps it contains.
struct Feed: Codable, Hashable, Sendable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [FeedLink]?
    let copyright: String?
    let country: String?
    let icon: String?
    let updated: String?
    let results: [AppResult]?

    init(
        title: String?,
        id: String?,
        author: Author?,
        links: [FeedLink]?,
        copyright: String?,
        country: String?,
        icon: String?,
        updated: String?,
        results: [AppResult]?
    ) {
        self.title = title
        self.id = id
        self.author = author
        self.links = links
        self.copyright = copyright
        self.country = country
        self.icon = icon
        self.updated = updated
        self.results = results
    }

    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        author = try container.decodeIfPresent(Author.self, forKey: .author)
        links = try container.decodeIfPresent([FeedLink].self, forKey: .links)
        copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        icon = try container.decodeIfPresent(String.self, forKey: .icon)
        updated = try container.decodeIfPresent(String.self, forKey: .updated)
        results = try container.decodeIfPresent([AppResult].self, forKey: .results)
    }

    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(links, forKey: .links)
        try container.encodeIfPresent(copyright, forKey: .copyright)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(icon, forKey: .icon)
        try container.encodeIfPresent(updated, forKey: .updated)
        try container.encodeIfPresent(results, forKey: .results)
    }

    enum CodingKeys: String, CodingKey {
        case title, id, author, links, copyright, country, icon, updated, results
    }
}
