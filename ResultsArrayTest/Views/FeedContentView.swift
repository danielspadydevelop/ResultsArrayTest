//
//  FeedContentView.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/9/26.
//

import SwiftUI

struct FeedContentView: View {
    let state: FeedViewState
    let onSelect: (AppResult) -> Void
    let onRefresh: () async -> Void
    let onRetry: () -> Void

    var body: some View {
        switch state {
        case .loading:
            LoadingView()
        case .error(let message):
            ErrorView(message: message, onRetry: onRetry)
        case .results(let apps):
            ResultsListView(
                apps: apps,
                onSelect: onSelect,
                onRefresh: onRefresh
            )
        case .empty:
            EmptyStateView(onRetry: onRetry)
        }
    }
}
