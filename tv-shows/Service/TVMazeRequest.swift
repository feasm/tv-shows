//
//  TVMazeRequest.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import Foundation

enum TVMazeRequest {
    case fetchShows
    case fetchPeople
    case searchShow(String)
    case getShow(Int)
}

extension TVMazeRequest: EndpointType {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchShows:
            return "shows"
        case .fetchPeople:
            return "people"
        case .searchShow:
            return "search/shows"
        case .getShow(let id):
            return "shows/\(id)"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: KeyValuePairs<String, String> {
        switch self {
        case .searchShow(let searchText):
            return ["q": searchText]
        case .getShow:
            return [
                "embed[]": "cast",
                "embed[]": "episodes"
            ]
        default:
            return [:]
        }
    }
    
    var headers: [String: String]? {
        [:]
    }
}
