//
//  ShowListViewModel.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import Combine

final class ShowListViewModel: ObservableObject {
    private var showViewModels: [ShowViewModel]
    @Published var filteredShowViewModels: [ShowViewModel]
    @Published var title: String = ""
    @Published var searchText: String = ""
    
    private var cancelBag = [AnyCancellable]()
    
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
                
                self.filteredShowViewModels = self.showViewModels
                                                    .filter({ $0.name.contains(newText) })
            }
            .store(in: &cancelBag)
    }
    
    func resetSearch() {
        filteredShowViewModels = showViewModels
    }
}
