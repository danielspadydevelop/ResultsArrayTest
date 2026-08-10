//
//  AppDetailView.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import SwiftUI

struct AppDetailView: View {
    let app: AppResult
    let coordinator: NavigationCoordinator

    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    AsyncImage(url: artworkURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.2))
                            .overlay(ProgressView())
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    Spacer()
                }
                .listRowBackground(Color.clear)

                LabeledContent("Name", value: app.name ?? "—")
                LabeledContent("Artist", value: app.artistName ?? "—")
                LabeledContent("Release Date", value: app.releaseDate ?? "—")
                LabeledContent("Kind", value: app.kind ?? "—")

                if let urlString = app.url, let url = URL(string: urlString) {
                    Link("Open in App Store", destination: url)
                }
            }

            if let genres = app.genres, !genres.isEmpty {
                Section("Genres") {
                    ForEach(genres) { genre in
                        Button {
                            coordinator.navigate(to: .genreDetail(genre))
                        } label: {
                            HStack {
                                Text(genre.name ?? "Unknown Genre")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                                    .accessibilityHidden(true)
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                }
            }
        }
        .navigationTitle(app.name ?? "App Details")
    }

    private var artworkURL: URL? {
        guard let urlString = app.artworkUrl100 else { return nil }
        return URL(string: urlString)
    }
}
