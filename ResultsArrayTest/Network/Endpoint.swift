//
//  Endpoint.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// Represents the API endpoints used by the app.
enum Endpoint {
    case topFreeApps(country: String = "us", count: Int = 50)

    var url: URL? {
        switch self {
        case .topFreeApps(let country, let count):
            return URL(string: "https://rss.marketingtools.apple.com/api/v2/\(country)/apps/top-free/\(count)/apps.json")
        }
    }
}
