//
//  RouteDestinationView.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import SwiftUI

struct RouteDestinationView: View {
    let route: AppRoute
    let coordinator: NavigationCoordinator

    var body: some View {
        switch route {
        case .appDetail(let app):
            AppDetailView(app: app, coordinator: coordinator)
        case .genreDetail(let genre):
            GenreDetailView(genre: genre)
        case .author(let author):
            AuthorView(author: author)
        case .feedInfo(let feed):
            FeedInfoView(feed: feed, coordinator: coordinator)
        }
    }
}
