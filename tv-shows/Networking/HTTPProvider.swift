//
//  Provider.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badURL
    case internalServerError(_ error: Error)
    case invalidResponse
    case noData
}

final class HTTPProvider {
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, NetworkError> {
        var url = endpoint.baseURL
        url.appendPathComponent(endpoint.path)
        
        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = endpoint.parameters.map { (element) in
            URLQueryItem(name: element.key, value: element.value)
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        return session.dataTaskPublisher(for: request)
                        .tryMap { output -> Data in
                            return output.data
                        }
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError { error in
                            return .internalServerError(error)
                        }
                        .receive(on: DispatchQueue.main)
                        .eraseToAnyPublisher()
    }
    
}
