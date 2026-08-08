//
//  FeedInfoView.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import SwiftUI

struct FeedInfoView: View {
    let feed: Feed
    let coordinator: NavigationCoordinator

    var body: some View {
        List {
            Section("Feed") {
                LabeledContent("Title", value: feed.title ?? "—")
                LabeledContent("Country", value: feed.country ?? "—")
                LabeledContent("Copyright", value: feed.copyright ?? "—")
                LabeledContent("Updated", value: feed.updated ?? "—")

                if let iconString = feed.icon, let url = URL(string: iconString) {
                    Link("Feed Icon", destination: url)
                }
            }

            if let author = feed.author {
                Section("Author") {
                    Button {
                        coordinator.navigate(to: .author(author))
                    } label: {
                        HStack {
                            Text(author.name ?? "Unknown")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }

            if let links = feed.links, !links.isEmpty {
                Section("Links") {
                    ForEach(links) { link in
                        if let urlString = link.urlString, let url = URL(string: urlString) {
                            Link(urlString, destination: url)
                        } else {
                            Text("Invalid link")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            if let results = feed.results {
                Section("Results") {
                    LabeledContent("Count", value: "\(results.count)")
                }
            }
        }
        .navigationTitle("Feed Info")
    }
}
