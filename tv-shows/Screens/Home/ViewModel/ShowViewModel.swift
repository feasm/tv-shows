//
//  ShowViewModel.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import Foundation

struct ShowViewModel: Hashable {
    let id: Int
    let name: String
    let genres: [String]
    let schedule: String
    let rating: String
    let imageURL: String
    let summary: String
    let type: String
    let language: String
    let status: String
    
    init(movie: ShowModel) {
        self.id = movie.id
        self.name = movie.name
        self.genres = movie.genres
        self.imageURL = movie.image?.medium ?? "photo"
        self.summary = movie.summary.htmlToString()
        self.type = movie.type
        self.language = movie.language
        self.status = movie.status
        
        self.schedule = movie.formatSchedule()
        self.rating = movie.formatRating()
    }
}
