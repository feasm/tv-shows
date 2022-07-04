//
//  ShowDetailViewModel.swift
//  tv-shows
//
//  Created by Felipe Melo on 03/07/22.
//

import Combine
import SwiftUI

protocol ShowDetailViewModel: ObservableObject {
    var isLoading: Bool { get }
    
    var name: String { get }
    var genres: [String] { get }
    var schedule: String { get }
    var rating: String { get }
    var imageURL: String { get }
    var summary: String { get }
    var type: String { get }
    var language: String { get }
    var status: String { get }
    
    func getShow()
}

final class ShowDetailViewModelImpl: ShowDetailViewModel {
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
                    .map({ ActorViewModel(name: $0.person.name ?? "",
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
}

struct ActorViewModel: Hashable {
    let name: String
    let photo: String
}

struct EpisodeViewModel: Hashable {
    let name: String
    let season: Int
    let runtime: Int
    let rating: String
    let image: String
    let summary: String
    
    init(model: EpisodeModel) {
        self.name = model.formatEpisodeName()
        self.season = model.season ?? 0
        self.runtime = model.runtime ?? 0
        self.rating = model.formatRating()
        self.image = model.image?.medium ?? ""
        self.summary = model.summary?.htmlToString() ?? ""
    }
}

enum LocalError: Error {
    case notFound
}

protocol LocalStorage {
    func addFavorite(show: ShowModel)
    func removeFavorite(show: ShowModel)
    func checkIsFavorite(id: Int) -> Bool
    func getFavorites() -> [ShowModel]
}

final class LocalStorageImpl: LocalStorage {
    
    // MARK: - Constants
    
    static let favoriteKey = "favoriteList"
    
    // MARK: - Properties
    
    let userDefaults: UserDefaults
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func addFavorite(show: ShowModel) {
        var favoriteList = getFavorites()
        
        if !favoriteList.contains(where: { $0.id == show.id }) {
            favoriteList.append(show)
        }
        
        if let encodedData = try? encoder.encode(favoriteList) {
            userDefaults.set(encodedData, forKey: LocalStorageImpl.favoriteKey)
        }
    }
    
    func removeFavorite(show: ShowModel) {
        var favoriteList = getFavorites()
        
        favoriteList.removeAll(where: { $0.id == show.id })
        
        if let encodedData = try? encoder.encode(favoriteList) {
            userDefaults.set(encodedData, forKey: LocalStorageImpl.favoriteKey)
        }
    }
    
    func checkIsFavorite(id: Int) -> Bool {
        let favoriteList = getFavorites()
        
        return favoriteList.contains(where: { $0.id == id })
    }
    
    func getFavorites() -> [ShowModel] {
        if let favoriteList  = userDefaults.data(forKey: LocalStorageImpl.favoriteKey) {
            let showList = try? decoder.decode([ShowModel].self, from: favoriteList)
            
            return showList?.sorted(by: { $0.name < $1.name }) ?? []
        }
        
        return []
    }
    
}
