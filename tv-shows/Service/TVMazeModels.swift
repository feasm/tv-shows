//
//  HomeModels.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import Foundation
import SwiftUI

struct SearchModel: Decodable {
    let show: ShowModel
}

struct ShowModel: Codable {
    let id: Int
    let name: String
    let genres: [String]
    let schedule: ScheduleModel
    let rating: RatingModel
    let image: ImageModel?
    let summary: String
    let type: String
    let language: String
    let status: String
    let moreInfo: MoreInfoModel?
    
    private enum CodingKeys: String, CodingKey {
        case moreInfo = "_embedded"
        
        case id
        case name
        case genres
        case schedule
        case rating
        case image
        case summary
        case type
        case language
        case status
    }
    
    func formatRating() -> String {
        if let rating = rating.average {
            return "\(rating) / 10"
        } else {
            return "No evaluations"
        }
    }
    
    func formatSchedule() -> String {
        guard let lastDay = schedule.days.last else {
            return "No schedule at the moment"
        }
        
        if schedule.days.count == 1 {
            return lastDay + " at \(schedule.time)"
        }
        
        let daysWithoutLast = schedule.days.dropLast()
        let joinedDays = daysWithoutLast.joined(separator: ", ") + " and \(lastDay)"
        return joinedDays + " at \(schedule.time)"
    }
}

struct ScheduleModel: Codable {
    let time: String
    var days: [String]
}

struct RatingModel: Codable {
    let average: Double?
}

struct ImageModel: Codable, Hashable {
    let medium: String
    let original: String
}

struct MoreInfoModel: Codable {
    let cast: [CastModel]
    let episodes: [EpisodeModel]
}

struct EpisodeModel: Codable {
    let name: String?
    let season: Int?
    let number: Int?
    let runtime: Int?
    let rating: RatingModel?
    let image: ImageModel?
    let summary: String?
    let airdate: String?
    
    func formatEpisodeName() -> String {
        let name = self.name ?? ""
        let number = self.number ?? 0
        
        return "Episode \(number) - \(name)"
    }
    
    func formatRating() -> String {
        if let rating = rating?.average {
            return "\(rating) / 10"
        } else {
            return "No evaluations"
        }
    }
}

struct CastModel: Codable {
    let person: PersonModel
    let character: CharacterModel
}

struct PersonModel: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let birthday: String?
    let image: ImageModel?
    let country: CountryModel?
}

struct CharacterModel: Codable {
    let image: ImageModel?
}

struct CountryModel: Codable {
    let name: String?
}

struct PersonShowModel: Decodable {
    let type: String?
    let show: SearchModel?
    
    private enum CodingKeys: String, CodingKey {
        case type
        case show = "_embedded"
    }
}
