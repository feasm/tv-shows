//
//  PersonViewModel.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import Foundation

struct PersonViewModel: Hashable {
    let id: Int
    let name: String
    let birthday: String
    let photo: String
    let country: String
    
    init(personModel: PersonModel) {
        self.id = personModel.id ?? 0
        self.name = personModel.name ?? ""
        self.birthday = personModel.birthday ?? "Unknown birthday"
        self.photo = personModel.image?.medium ?? "photo"
        self.country = personModel.country?.name ?? "Unknown country"
    }
}
