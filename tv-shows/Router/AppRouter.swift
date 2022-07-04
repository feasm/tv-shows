//
//  AppRouter.swift
//  tv-shows
//
//  Created by Felipe Melo on 03/07/22.
//

import SwiftUI

protocol Router {
    func navigateToHomeView() -> AnyView
    func navigateToPeopleView() -> AnyView
    func navigateToSearchView() -> AnyView
    func navigateToShowDetailView(id: Int) -> AnyView
}

final class AppRouter {
    
    static func navigateToHomeView() -> AnyView {
        let provider = HTTPProvider(session: URLSession.shared)
        let service = TVMazeServiceImpl(provider: provider)
        let localStorage = LocalStorageImpl()
        let viewModel = HomeViewModelImpl(service: service, localStorage: localStorage)
        
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
    
    static func navigateToSearchView(viewModel: HomeViewModelImpl) -> AnyView {
        return AnyView(
            SearchView(viewModel: viewModel)
        )
    }
    
    static func navigateToShowDetailView(id: Int) -> AnyView {
        let provider = HTTPProvider(session: URLSession.shared)
        let service = TVMazeServiceImpl(provider: provider)
        let localStorage = LocalStorageImpl()
        let viewModel = ShowDetailViewModelImpl(localStorage: localStorage, service: service, showId: id)
        
        return AnyView(
            ShowDetailView(viewModel: viewModel)
        )
    }
}
