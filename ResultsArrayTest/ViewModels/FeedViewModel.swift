//
//  FeedViewModel.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import Foundation

/// View model that drives the app's main feed list.
@Observable
@MainActor
final class FeedViewModel {
    private let repository: FeedRepositoryProtocol

    var feed: Feed?
    var isLoading = false
    var errorMessage: String?

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
