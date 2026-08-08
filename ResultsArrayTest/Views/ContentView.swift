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
            Group {
                if viewModel.isLoading {
                    LoadingView()
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage) {
                        Task { await viewModel.loadFeed() }
                    }
                } else if let results = viewModel.feed?.results {
                    resultsList(results)
                } else {
                    EmptyStateView {
                        Task { await viewModel.loadFeed() }
                    }
                }
            }
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
                destination(for: route)
            }
        }
        .task {
            await viewModel.loadFeed()
        }
    }

    @ViewBuilder
    private func resultsList(_ results: [AppResult]) -> some View {
        List(results) { app in
            Button {
                coordinator.navigate(to: .appDetail(app))
            } label: {
                AppRowView(app: app)
            }
            .buttonStyle(.plain)
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.loadFeed()
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
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
