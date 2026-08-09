//
//  ResultsListView.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import SwiftUI

struct ResultsListView: View {
    let apps: [AppResult]
    let onSelect: (AppResult) -> Void
    let onRefresh: () async -> Void

    var body: some View {
        List(apps) { app in
            Button {
                onSelect(app)
            } label: {
                AppRowView(app: app)
            }
            .buttonStyle(.plain)
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
}
