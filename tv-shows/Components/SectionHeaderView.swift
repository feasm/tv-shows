//
//  SectionView.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    var seeMore: Bool
    
    init(_ title: String, seeMore: Bool = true) {
        self.title = title
        self.seeMore = seeMore
    }
    
    var body: some View {
        HStack {
            
            TitleText(title)
            
            Spacer()
            
            // TODO
            ButtonLabel(text: "See more")
            
        }
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView("All movies")
    }
}
