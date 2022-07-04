//
//  HomeViewModel.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI
import Combine

protocol HomeViewModel: ObservableObject {
    var isLoading: Bool { get }
    var showViewModels: [ShowViewModel] { get }
    var favoriteShowViewModels: [ShowViewModel] { get }
    var filteredShowViewModels: [ShowViewModel] { get }
    var sectionViewModels: [SectionViewModel] { get }
    var searchText: String { get set }
    var hasSearchResults: Bool { get }
    
    func fetchShows()
    func searchShows()
    
    func clearSearch()
    
    func navigateToSearchView() -> AnyView
    func navigateToShowDetailView(id: Int) -> AnyView
}

final class HomeViewModelImpl: HomeViewModel {
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
    
    func navigateToSearchView() -> AnyView {
        return AppRouter.navigateToSearchView(viewModel: self)
    }
    
    func navigateToShowDetailView(id: Int) -> AnyView {
        return AppRouter.navigateToShowDetailView(id: id)
    }
}

struct ShowViewModel: Hashable {
    let id: Int
    let name: String
    let genres: [String]
    let schedule: String
    let rating: String
    let imageURL: String
    let summary: String
    let type: String
    let language: String
    let status: String
    
    init(movie: ShowModel) {
        self.id = movie.id
        self.name = movie.name
        self.genres = movie.genres
        self.imageURL = movie.image?.medium ?? "photo"
        self.summary = movie.summary.htmlToString()
        self.type = movie.type
        self.language = movie.language
        self.status = movie.status
        
        self.schedule = movie.formatSchedule()
        self.rating = movie.formatRating()
    }
}

final class SectionViewModel: ObservableObject {
    let title: String
    let showViewModels: [ShowViewModel]
    
    var numberOfShows = 0
    @Published var filteredShowViewModels = [ShowViewModel]()
    
    init(title: String, showViewModels: [ShowViewModel]) {
        self.title = title
        self.showViewModels = showViewModels
    }
    
    func updateShows() {
        numberOfShows += 4
        filteredShowViewModels = Array(showViewModels.prefix(numberOfShows))
    }
    
    func navigateToShowDetailView(id: Int) -> AnyView {
        return AppRouter.navigateToShowDetailView(id: id)
    }
}
