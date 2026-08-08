//
//  ResultsArrayTestApp.swift
//  ResultsArrayTest
//
//  Created by Daniel Spady on 8/7/26.
//

import SwiftUI

@main
struct ResultsArrayTestApp: App {
    private let networkService: NetworkServiceProtocol
    private let repository: FeedRepositoryProtocol
    private let viewModel: FeedViewModel
    private let coordinator: NavigationCoordinator

    init() {
        self.networkService = NetworkService()
        self.repository = FeedRepository(networkService: networkService)
        self.viewModel = FeedViewModel(repository: repository)
        self.coordinator = NavigationCoordinator()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel, coordinator: coordinator)
        }
    }
}
