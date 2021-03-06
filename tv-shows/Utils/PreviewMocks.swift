//
//  PreviewMocks.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import Foundation

struct PreviewMocks {
    static let text = "Kirby Buckets"
    
    static let summary = "<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby's sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>"
    
    static let genreList = ["Comedy", "Drama", "Suspense", "Team"]
    
    static let schedule = ScheduleModel(time: "10:00", days: ["Monday, Friday, Sunday"])
    
    static let showRating = RatingModel(average: 8.5)
    
    static let episodeImage = ImageModel(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg", original: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg")
    
    static let episode = EpisodeModel(name: "Pilot", season: 1, number: 1, runtime: 90, rating: showRating, image: episodeImage, summary: summary, airdate: "29-05-2009")
    
    static let moreInfo = MoreInfoModel(cast: [CastModel(person: PersonModel(id: 0, url: "", name: "Tom Holland", birthday: "05-02-1970", image: nil, country: CountryModel(name: "United States")),
                                                         character: CharacterModel(image: showImage))], episodes: [episode])
    
    static let showImage = ImageModel(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/1/4600.jpg", original: "figure.walk")
    
    static let thorShow = ShowModel(id: 1, name: "Thor", genres: genreList, schedule: schedule, rating: showRating, image: showImage, summary: summary, type: "SCRIPTED", language: "English", status: "Ended", moreInfo: moreInfo)
    
    static let movies = [
        thorShow
   ]
    static let movieSection = SectionViewModel(title: "All movies",
                                               showViewModels: movies.map({ ShowViewModel(show: $0) }))
    
    static let stephenKing = PersonModel(id: 100, url: "https://static.tvmaze.com/uploads/images/medium_portrait/1/4600.jpg", name: "Stephen King", birthday: "01-01-2000", image: showImage, country: nil)
}
