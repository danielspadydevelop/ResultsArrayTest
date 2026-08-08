//
//  AppRoute.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// Every navigable destination in the app.
enum AppRoute: Hashable {
    case appDetail(AppResult)
    case genreDetail(Genre)
    case author(Author)
    case feedInfo(Feed)
}
