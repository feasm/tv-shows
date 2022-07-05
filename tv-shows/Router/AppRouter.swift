//
//  AppRouter.swift
//  tv-shows
//
//  Created by Felipe Melo on 03/07/22.
//

import SwiftUI

final class AppRouter {
    
    static let localStorage = LocalStorageImpl()
    
    static func navigateToHomeView() -> AnyView {
        let provider = HTTPProvider(session: URLSession.shared)
        let service = TVMazeServiceImpl(provider: provider)
        let viewModel = HomeViewModel(service: service, localStorage: localStorage)
        
        return AnyView(
            HomeView(viewModel: viewModel)
        )
    }
    
    static func navigateToPeopleView() -> AnyView {
        let provider = HTTPProvider(session: URLSession.shared)
        let service = TVMazeServiceImpl(provider: provider)
        let viewModel = PeopleViewModel(service: service)
        
        return AnyView(
            PeopleView(viewModel: viewModel)
        )
    }
    
    static func navigateToPersonDetails(id: Int) -> AnyView {
        return AnyView(
            Text("Person Details")
        )
    }
    
    static func navigateToSearchView(viewModel: HomeViewModel) -> AnyView {
        return AnyView(
            SearchView(viewModel: viewModel)
        )
    }
    
    static func navigateToShowDetailView(id: Int) -> AnyView {
        let provider = HTTPProvider(session: URLSession.shared)
        let service = TVMazeServiceImpl(provider: provider)
        let viewModel = ShowDetailViewModelImpl(localStorage: localStorage, service: service, showId: id)
        
        return AnyView(
            ShowDetailView(viewModel: viewModel)
        )
    }
    
    static func navigateToEpisodeView(viewModel: EpisodeViewModel) -> AnyView {
        return AnyView(
            EpisodeView(viewModel: viewModel)
        )
    }
    
    static func navigateToShowListView(viewModels: [ShowViewModel], title: String) -> AnyView {
        let viewModel = ShowListViewModel(title: title, showViewModels: viewModels)
        
        return AnyView(
            ShowListView(viewModel: viewModel)
        )
    }
}
