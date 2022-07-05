//
//  SectionView.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    
    init(_ title: String) {
        self.title = title
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
