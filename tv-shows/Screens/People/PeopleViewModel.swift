//
//  PeopleViewModel.swift
//  tv-shows
//
//  Created by Felipe Melo on 04/07/22.
//

import Combine
import Foundation
import SwiftUI

final class PeopleViewModel: ObservableObject {
    let service: TVMazeService
    
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var peopleViewModels = [PersonViewModel]()
    
    private var peopleModels = [PersonModel]()
    private var cancelBag = [AnyCancellable]()
    
    init(service: TVMazeService) {
        self.service = service
        
        observeSearchText()
    }
    
    func observeSearchText() {
        $searchText
            .sink { [weak self] newText in
                guard let self = self else { return }
                guard !newText.isEmpty else {
                    self.resetSearch()
                    return
                }
                
                self.peopleViewModels = self.peopleModels.filter({ ($0.name ?? "").contains(newText) })
                                                            .map({ PersonViewModel(personModel: $0) })
            }
            .store(in: &cancelBag)
    }
    
    func fetchPeople() {
        isLoading = true
        
        service
            .fetchPeople()
            .sink { [weak self] result in
                self?.isLoading = false
                
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] peopleModels in
                guard let self = self else { return }
                
                self.peopleModels = peopleModels
                self.resetSearch()
            }
            .store(in: &cancelBag)

    }
    
    func navigateToPersonDetails(id: Int) -> AnyView {
        AppRouter.navigateToPersonDetails(id: id)
    }
    
    func resetSearch() {
        peopleViewModels = peopleModels.map({ PersonViewModel(personModel: $0) })
    }
}

struct PersonViewModel: Hashable {
    let id: Int
    let name: String
    let birthday: String
    let photo: String
    let country: String
    
    init(personModel: PersonModel) {
        self.id = personModel.id ?? 0
        self.name = personModel.name ?? ""
        self.birthday = personModel.birthday ?? "Unknown birthday"
        self.photo = personModel.image?.medium ?? "photo"
        self.country = personModel.country?.name ?? "Unknown country"
    }
}
