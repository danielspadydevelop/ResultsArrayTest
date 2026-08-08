//
//  AuthorView.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import SwiftUI

struct AuthorView: View {
    let author: Author

    var body: some View {
        List {
            Section {
                LabeledContent("Name", value: author.name ?? "—")

                if let urlString = author.url, let url = URL(string: urlString) {
                    Link("Website", destination: url)
                }
            }
        }
        .navigationTitle(author.name ?? "Author")
    }
}
