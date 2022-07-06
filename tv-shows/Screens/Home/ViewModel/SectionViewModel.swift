//
//  SectionViewModel.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import SwiftUI

class SectionViewModel: ObservableObject {
    let title: String
    @Published var showViewModels: [ShowViewModel]
    
    init(title: String, showViewModels: [ShowViewModel]) {
        self.title = title
        self.showViewModels = showViewModels
    }
    
    func navigateToShowDetailView(id: Int) -> AnyView {
        return AppRouter.navigateToShowDetailView(id: id)
    }
    
    func navigateToShowListView() -> AnyView {
        return AppRouter.navigateToShowListView(viewModels: showViewModels, title: title)
    }
}

final class FavoritesSectionViewModel: SectionViewModel {
    override func navigateToShowListView() -> AnyView {
        return AppRouter.navigateToFavoriteListView(viewModels: showViewModels, title: title)
    }
}
