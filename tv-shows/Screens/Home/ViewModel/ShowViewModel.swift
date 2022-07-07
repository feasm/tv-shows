//
//  ShowViewModel.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import SwiftUI

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
    
    init(show: ShowModel) {
        self.id = show.id
        self.name = show.name
        self.genres = show.genres
        self.imageURL = show.image?.medium ?? "photo"
        self.summary = show.summary.htmlToString()
        self.type = show.type
        self.language = show.language
        self.status = show.status
        
        self.schedule = show.formatSchedule()
        self.rating = show.formatRating()
    }
    
    init() {
        self.id = 0
        self.name = ""
        self.genres = []
        self.imageURL = "photo"
        self.summary = ""
        self.type = ""
        self.language = ""
        self.status = ""
        
        self.schedule = ""
        self.rating = ""
    }
    
    func navigateToShowDetailView(id: Int) -> AnyView {
        return AppRouter.navigateToShowDetailView(id: id)
    }
}
