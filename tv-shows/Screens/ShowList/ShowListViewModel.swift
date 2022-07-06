//
//  ShowListViewModel.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import Combine
import Foundation

class ShowListViewModel: ObservableObject {
    var showViewModels: [ShowViewModel]
    @Published var filteredShowViewModels: [ShowViewModel]
    @Published var title: String = ""
    @Published var searchText: String = ""
    
    var cancelBag = [AnyCancellable]()
    
    init(title: String, showViewModels: [ShowViewModel]) {
        self.title = title
        self.showViewModels = showViewModels
        self.filteredShowViewModels = showViewModels
        self.observeSearchText()
    }
    
    func observeSearchText() {
        $searchText
            .sink { [weak self] newText in
                guard let self = self else { return }
                guard !newText.isEmpty else {
                    self.resetSearch()
                    return
                }
                
                self.filterShows(by: newText)
            }
            .store(in: &cancelBag)
    }
    
    func filterShows(by text: String) {
        if text.isEmpty {
            filteredShowViewModels = showViewModels
        } else {        
            filteredShowViewModels = showViewModels.filter({ $0.name.contains(text) })
        }
    }
    
    func resetSearch() {
        filteredShowViewModels = showViewModels
    }
}

class FavoriteListViewModel: ShowListViewModel {
    let localStorage: LocalStorage
    
    init(title: String, showViewModels: [ShowViewModel], localStorage: LocalStorage) {
        self.localStorage = localStorage
        super.init(title: title, showViewModels: showViewModels)
        observeUpdateFavorites()
    }
    
    func observeUpdateFavorites() {
        localStorage.onUpdate
            .receive(on: RunLoop.main)
            .sink { [weak self] showModels in
                guard let self = self else { return }
                
                self.showViewModels = showModels.map({ ShowViewModel(movie: $0) })
                self.filterShows(by: self.searchText)
            }
            .store(in: &cancelBag)
    }
    
    
}
