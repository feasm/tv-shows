//
//  EpisodeViewModel.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import Foundation

struct EpisodeViewModel: Hashable {
    let name: String
    let season: String
    let runtime: String
    let rating: String
    let image: String
    let summary: String
    let airdate: String
    
    init(model: EpisodeModel) {
        self.name = model.formatEpisodeName()
        self.season = "\(model.season ?? 0)"
        self.runtime = "\(model.runtime ?? 0) minutes"
        self.rating = model.formatRating()
        self.image = model.image?.medium ?? ""
        self.summary = model.summary?.htmlToString() ?? ""
        self.airdate = model.airdate ?? ""
    }
}
