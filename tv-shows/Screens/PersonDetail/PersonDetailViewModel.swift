//
//  PersonDetailViewModel.swift
//  tv-shows
//
//  Created by Felipe Melo on 06/07/22.
//

import SwiftUI
import Combine

final class PersonDetailViewModel: ObservableObject {
    let service: TVMazeService
    
    @Published var isLoading = false
    @Published var photo = ""
    @Published var name = ""
    @Published var personShowsViewModel = [PersonShowViewModel]()
    
    private let personModel: PersonModel
    private var cancelBag = [AnyCancellable]()
    
    init(service: TVMazeService, personModel: PersonModel) {
        self.service = service
        self.personModel = personModel
        self.photo = personModel.image?.medium ?? "photo"
        self.name = personModel.name ?? "Name unavailable"
    }
    
    func getPersonDetail() {
        isLoading = true
        
        service.getPersonShows(id: personModel.id ?? 0)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
                self?.isLoading = false
            } receiveValue: { personShowList in
                self.personShowsViewModel = personShowList.map({ PersonShowViewModel(personShowModel: $0) })
            }
            .store(in: &cancelBag)
    }
    
    func navigateToShowDetailView(id: Int) -> AnyView {
        return AppRouter.navigateToShowDetailView(id: id)
    }
}
