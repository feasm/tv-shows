//
//  HomeService.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import Combine
import Foundation

protocol TVMazeService {
    func fetchShows() -> AnyPublisher<[ShowModel], NetworkError>
    func fetchPeople() -> AnyPublisher<[PersonModel], NetworkError>
    
    func searchShow(searchText: String) -> AnyPublisher<[SearchModel], NetworkError>
    
    func getShow(id: Int) -> AnyPublisher<ShowModel, NetworkError>
    func getPersonShows(id: Int) -> AnyPublisher<[PersonShowModel], NetworkError>
}

final class TVMazeServiceImpl: ObservableObject, TVMazeService {
    
    let provider: HTTPProvider<TVMazeRequest>
    
    init(provider: HTTPProvider<TVMazeRequest> = HTTPProvider(session: URLSession.shared)) {
        self.provider = provider
    }
    
    func fetchShows() -> AnyPublisher<[ShowModel], NetworkError> {
        return provider.request(.fetchShows)
    }
    
    func fetchPeople() -> AnyPublisher<[PersonModel], NetworkError> {
        return provider.request(.fetchPeople)
    }
    
    func searchShow(searchText: String) -> AnyPublisher<[SearchModel], NetworkError> {
        return provider.request(.searchShow(searchText))
    }
    
    func getShow(id: Int) -> AnyPublisher<ShowModel, NetworkError> {
        return provider.request(.getShow(id))
    }
    
    func getPersonShows(id: Int) -> AnyPublisher<[PersonShowModel], NetworkError> {
        return provider.request(.getPersonShows(id))
    }
    
}
