//
//  GenreDetailView.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import SwiftUI

struct GenreDetailView: View {
    let genre: Genre

    var body: some View {
        List {
            Section {
                LabeledContent("Name", value: genre.name ?? "—")
                LabeledContent("Genre ID", value: genre.genreId ?? "—")

                if let urlString = genre.url, let url = URL(string: urlString) {
                    Link("View on iTunes", destination: url)
                }
            }
        }
        .navigationTitle(genre.name ?? "Genre")
    }
}
