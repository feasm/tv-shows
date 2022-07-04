//
//  EndpointType.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: KeyValuePairs<String, String> { get }
    var headers: [String: String]? { get }
}
