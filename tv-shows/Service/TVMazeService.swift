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
}

final class TVMazeServiceImpl: ObservableObject, TVMazeService {
    
    let provider: HTTPProvider
    
    init(provider: HTTPProvider = HTTPProvider(session: URLSession.shared)) {
        self.provider = provider
    }
    
    func fetchShows() -> AnyPublisher<[ShowModel], NetworkError> {
        return provider.request(TVMazeRequest.fetchShows)
    }
    
    func fetchPeople() -> AnyPublisher<[PersonModel], NetworkError> {
        return provider.request(TVMazeRequest.fetchPeople)
    }
    
    func searchShow(searchText: String) -> AnyPublisher<[SearchModel], NetworkError> {
        return provider.request(TVMazeRequest.searchShow(searchText))
    }
    
    func getShow(id: Int) -> AnyPublisher<ShowModel, NetworkError> {
        return provider.request(TVMazeRequest.getShow(id))
    }
    
}
