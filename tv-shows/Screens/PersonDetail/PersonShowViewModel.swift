//
//  PersonShowViewModel.swift
//  tv-shows
//
//  Created by Felipe Melo on 06/07/22.
//

import Foundation

struct PersonShowViewModel: Hashable {
    let role: String
    let showViewModel: ShowViewModel
    
    init(personShowModel: PersonShowModel) {
        self.role = personShowModel.type ?? ""
        
        if let show = personShowModel.show?.show {
            self.showViewModel = ShowViewModel(show: show)
        } else {
            self.showViewModel = ShowViewModel()
        }
    }
    
}
