//
//  ShowDetailViewModel.swift
//  tv-shows
//
//  Created by Felipe Melo on 03/07/22.
//

import Combine
import SwiftUI

final class ShowDetailViewModel: ObservableObject {
    let service: TVMazeService
    let localStorage: LocalStorage
    let showId: Int
    
    @Published var isLoading = false
    
    @Published var isFavorite: Bool
    @Published var name: String = ""
    @Published var genres: [String] = []
    @Published var schedule: String = ""
    @Published var rating: String = ""
    @Published var imageURL: String = ""
    @Published var summary: String = ""
    @Published var type: String = ""
    @Published var language: String = ""
    @Published var status: String = ""
    @Published var actors: [ActorViewModel] = []
    @Published var selectedSeason: Int = 1 {
        didSet {
            groupEpisodesBySeason()
        }
    }
    @Published var lastSeason: Int = 1
    @Published var episodes: [EpisodeViewModel] = []
    
    private var showModel: ShowModel?
    private var cancelBag = [AnyCancellable]()
    
    init(localStorage: LocalStorage, service: TVMazeService, showId: Int) {
        self.localStorage = localStorage
        self.service = service
        self.showId = showId
        self.isFavorite = localStorage.checkIsFavorite(id: showId)
    }
    
    func getShow() {
        isLoading = true
        
        service.getShow(id: showId)
            .sink { [weak self] result in
                self?.isLoading = false
                
                print(result)
            } receiveValue: { [weak self] showModel in
                guard let self = self else { return }
                self.showModel = showModel
                
                self.name = showModel.name
                self.genres = showModel.genres
                self.schedule = showModel.formatSchedule()
                self.rating = showModel.formatRating()
                self.imageURL = showModel.image?.medium ?? "photo"
                self.summary = showModel.summary.htmlToString()
                self.type = showModel.type
                self.language = showModel.language
                self.status = showModel.status
                self.actors = showModel.moreInfo?.cast
                    .map({ ActorViewModel(id: $0.person.id ?? 0,
                                          name: $0.person.name ?? "",
                                          photo: $0.character.image?.medium ?? "photo")
                    }) ?? []
                self.lastSeason = (showModel.moreInfo?.episodes.map({ $0.season ?? 1 }).max()) ?? 1
                self.groupEpisodesBySeason()
            }
            .store(in: &cancelBag)
    }
    
    func toggleFavorite() {
        guard let showModel = showModel else {
            return
        }

        isFavorite.toggle()
        
        if isFavorite {
            localStorage.addFavorite(show: showModel)
        } else {
            localStorage.removeFavorite(show: showModel)
        }
    }
    
    private func groupEpisodesBySeason() {
        let episodesOnSeason = showModel?.moreInfo?.episodes.filter({ $0.season == selectedSeason })
        episodes = episodesOnSeason?.map({ EpisodeViewModel(model: $0) }) ?? []
    }
    
    func navigateToPersonDetailView(id: Int) -> AnyView {
        guard let personModel = showModel?.moreInfo?.cast.first(where: { $0.person.id == id })?.person else {
            return AnyView(Text("Some error occurred, try again later"))
        }
        
        return AppRouter.navigateToPersonDetails(personModel: personModel)
    }
    
    func navigateToEpisodeView(episodeViewModel: EpisodeViewModel) -> AnyView {
        AppRouter.navigateToEpisodeView(viewModel: episodeViewModel)
    }
}
