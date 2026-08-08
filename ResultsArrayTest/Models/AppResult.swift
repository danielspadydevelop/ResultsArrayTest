//
//  AppResult.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// A single app entry inside the RSS feed's `results` array.
struct AppResult: Codable, Hashable, Identifiable, Sendable {
    let artistName: String?
    let appStoreId: String?
    let name: String?
    let releaseDate: String?
    let kind: String?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?

    /// Stable identity for SwiftUI lists. Falls back to the app id, then name,
    /// then a generated UUID so rows always have a usable identifier.
    var id: String {
        appStoreId ?? name ?? UUID().uuidString
    }

    init(
        artistName: String?,
        appStoreId: String?,
        name: String?,
        releaseDate: String?,
        kind: String?,
        artworkUrl100: String?,
        genres: [Genre]?,
        url: String?
    ) {
        self.artistName = artistName
        self.appStoreId = appStoreId
        self.name = name
        self.releaseDate = releaseDate
        self.kind = kind
        self.artworkUrl100 = artworkUrl100
        self.genres = genres
        self.url = url
    }

    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        appStoreId = try container.decodeIfPresent(String.self, forKey: .appStoreId)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        kind = try container.decodeIfPresent(String.self, forKey: .kind)
        artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100)
        genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        url = try container.decodeIfPresent(String.self, forKey: .url)
    }

    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(artistName, forKey: .artistName)
        try container.encodeIfPresent(appStoreId, forKey: .appStoreId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(artworkUrl100, forKey: .artworkUrl100)
        try container.encodeIfPresent(genres, forKey: .genres)
        try container.encodeIfPresent(url, forKey: .url)
    }

    enum CodingKeys: String, CodingKey {
        case artistName
        case appStoreId = "id"
        case name
        case releaseDate
        case kind
        case artworkUrl100
        case genres
        case url
    }
}
