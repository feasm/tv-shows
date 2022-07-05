//
//  HomeViewModel.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    private var service: TVMazeService
    private var localStorage: LocalStorage
    
    @Published var isLoading = false
    @Published var showViewModels = [ShowViewModel]()
    @Published var favoriteShowViewModels = [ShowViewModel]()
    @Published var filteredShowViewModels = [ShowViewModel]() {
        didSet {
            hasSearchResults = filteredShowViewModels.count > 0
        }
    }
    @Published var sectionViewModels = [SectionViewModel]()
    @Published var searchText = ""
    @Published var hasSearchResults: Bool = false
    
    var movies = [ShowModel]()
    
    private var cancelbag = [AnyCancellable]()
    
    init(service: TVMazeService, localStorage: LocalStorage) {
        self.service = service
        self.localStorage = localStorage
    }
    
    func fetchShows() {
        isLoading = true
        
        service.fetchShows()
                .sink { [weak self] result in
                    switch result {
                    case .finished:
                        self?.isLoading = false
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { [weak self] movies in
                    guard let self = self else { return }
                    
                    self.movies = movies
                    self.showViewModels = movies.map({ ShowViewModel(movie: $0) })
                    let allShowsSectionViewModel = SectionViewModel(title: "All movies", showViewModels: self.showViewModels)
                    
                    self.favoriteShowViewModels = self.localStorage.getFavorites().map({ ShowViewModel(movie: $0) })
                    let favoriteSectionViewModel = SectionViewModel(title: "Favorites", showViewModels: self.favoriteShowViewModels)
                    
                    self.sectionViewModels = [
                        allShowsSectionViewModel,
                        favoriteSectionViewModel
                    ]
                }
                .store(in: &cancelbag)

    }
    
    func searchShows() {
        isLoading = true
        
        service.searchShow(searchText: searchText)
                .sink { [weak self] result in
                    self?.isLoading = false
                    
                    switch result {
                    case .finished:
                        break
                    case .failure:
                        self?.filteredShowViewModels = []
                    }
                } receiveValue: { searchedShows in
                    self.filteredShowViewModels = searchedShows.map({ ShowViewModel(movie: $0.show) })
                }
                .store(in: &cancelbag)
    }
    
    func clearSearch() {
        filteredShowViewModels = []
    }
    
    func updateFavorites() {
        favoriteShowViewModels = self.localStorage.getFavorites().map({ ShowViewModel(movie: $0) })
        
        sectionViewModels.first(where: { $0.title == "Favorites" })?.showViewModels = favoriteShowViewModels
    }
    
    func navigateToSearchView() -> AnyView {
        return AppRouter.navigateToSearchView(viewModel: self)
    }
    
    func navigateToShowDetailView(id: Int) -> AnyView {
        return AppRouter.navigateToShowDetailView(id: id)
    }
}
