//
//  TVMazeServiceSpy.swift
//  tv-showsTests
//
//  Created by Felipe Melo on 06/07/22.
//

import Foundation
import Combine
@testable import tv_shows

final class TVMazeServiceSpy: TVMazeService {
    var searchText = ""
    
    var didCalledFetchShows = false
    var didCalledFetchPeople = false
    var didCalledSearchShow = false
    var didCalledGetShow = false
    var didCalledGetPersonShows = false
    
    func fetchShows() -> AnyPublisher<[ShowModel], NetworkError> {
        didCalledFetchShows = true
        return Just([PreviewMocks.thorShow])
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
    }
    
    func fetchPeople() -> AnyPublisher<[PersonModel], NetworkError> {
        didCalledFetchPeople = true
        return Just([PreviewMocks.stephenKing])
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
    }
    
    func searchShow(searchText: String) -> AnyPublisher<[SearchModel], NetworkError> {
        didCalledSearchShow = true
        self.searchText = searchText
        let searchModel = SearchModel(show: PreviewMocks.thorShow)
        return Just([searchModel])
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
    }
    
    func getShow(id: Int) -> AnyPublisher<ShowModel, NetworkError> {
        didCalledGetShow = true
        return Just(PreviewMocks.thorShow)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
    }
    
    func getPersonShows(id: Int) -> AnyPublisher<[PersonShowModel], NetworkError> {
        didCalledGetPersonShows = true
        let searchModel = SearchModel(show: PreviewMocks.thorShow)
        let personShowModel = PersonShowModel(type: "Director", show: searchModel)
        return Just([personShowModel])
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
    }
    
    
}
