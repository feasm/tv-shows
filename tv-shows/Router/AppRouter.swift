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
        let service = TVMazeServiceImpl()
        let localStorage = LocalStorageImpl()
        let viewModel = HomeViewModel(service: service, localStorage: localStorage)
        
        return AnyView(
            HomeView(viewModel: viewModel)
        )
    }
    
    static func navigateToPeopleView() -> AnyView {
        let service = TVMazeServiceImpl()
        let viewModel = PeopleViewModel(service: service)
        
        return AnyView(
            PeopleView(viewModel: viewModel)
        )
    }
    
    static func navigateToPersonDetails(personModel: PersonModel) -> AnyView {
        let service = TVMazeServiceImpl()
        let viewModel = PersonDetailViewModel(service: service, personModel: personModel)
        
        return AnyView(
            PersonDetailView(viewModel: viewModel)
        )
    }
    
    static func navigateToSearchView(viewModel: HomeViewModel) -> AnyView {
        return AnyView(
            SearchView(viewModel: viewModel)
        )
    }
    
    static func navigateToShowDetailView(id: Int) -> AnyView {
        let service = TVMazeServiceImpl()
        let viewModel = ShowDetailViewModel(localStorage: localStorage, service: service, showId: id)
        
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
    
    static func navigateToFavoriteListView(viewModels: [ShowViewModel], title: String) -> AnyView {
        let viewModel = FavoriteListViewModel(title: title, showViewModels: viewModels, localStorage: localStorage)
        
        return AnyView(
            ShowListView(viewModel: viewModel)
        )
    }
}
