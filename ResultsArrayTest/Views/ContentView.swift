//
//  ContentView.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: FeedViewModel
    @State private var coordinator: NavigationCoordinator

    init(viewModel: FeedViewModel, coordinator: NavigationCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            FeedContentView(
                state: viewModel.viewState,
                onSelect: { app in coordinator.navigate(to: .appDetail(app)) },
                onRefresh: { await viewModel.loadFeed() },
                onRetry: { Task { await viewModel.loadFeed() } }
            )
            .navigationTitle("Top Free Apps")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if let feed = viewModel.feed {
                        Button {
                            coordinator.navigate(to: .feedInfo(feed))
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                RouteDestinationView(route: route, coordinator: coordinator)
            }
        }
        .task {
            await viewModel.loadFeed()
        }
    }
}

#Preview {
    let sampleFeed = Feed(
        title: "Top Free Apps",
        id: "https://rss.marketingtools.apple.com/api/v2/us/apps/top-free/50/apps.json",
        author: Author(name: "Apple", url: "https://www.apple.com/"),
        links: [FeedLink(urlString: "https://rss.marketingtools.apple.com/api/v2/us/apps/top-free/50/apps.json")],
        copyright: "Copyright © 2026 Apple Inc. All rights reserved.",
        country: "us",
        icon: "https://www.apple.com/favicon.ico",
        updated: "Fri, 7 Aug 2026 19:10:05 +0000",
        results: [
            AppResult(
                artistName: "OpenAI OpCo, LLC",
                appStoreId: "6448311069",
                name: "ChatGPT",
                releaseDate: "2023-05-18",
                kind: "apps",
                artworkUrl100: "https://via.placeholder.com/100",
                genres: [
                    Genre(genreId: "6007", name: "Productivity", url: "https://itunes.apple.com/us/genre/id6007")
                ],
                url: "https://apps.apple.com/us/app/chatgpt/id6448311069"
            )
        ]
    )

    let mockService = MockNetworkService(result: RSSFeed(feed: sampleFeed))
    let repository = FeedRepository(networkService: mockService)
    let viewModel = FeedViewModel(repository: repository)
    let coordinator = NavigationCoordinator()

    ContentView(viewModel: viewModel, coordinator: coordinator)
}
