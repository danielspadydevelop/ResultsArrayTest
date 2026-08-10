//
//  FeedViewModel.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// Represents the possible states of the top free apps feed.
enum FeedViewState {
    case loading
    case error(String)
    case results([AppResult])
    case empty
}

/// View model that drives the app's main feed list.
@Observable
@MainActor
final class FeedViewModel {
    private let repository: FeedRepositoryProtocol

    var feed: Feed?
    var isLoading = false
    var errorMessage: String?

    /// The current feed state derived from the view model's properties.
    var viewState: FeedViewState {
        if isLoading { return .loading }
        if let errorMessage { return .error(errorMessage) }
        if let results = feed?.results, !results.isEmpty { return .results(results) }
        return .empty
    }

    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }

    /// Loads the top free apps feed asynchronously.
    func loadFeed() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            feed = try await repository.fetchTopFreeApps()
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
