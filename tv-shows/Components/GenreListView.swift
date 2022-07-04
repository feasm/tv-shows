//
//  GenreListView.swift
//  tv-shows
//
//  Created by Felipe Melo on 02/07/22.
//

import SwiftUI

struct GenreListView: View {
    var genreList: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(genreList, id: \.self) { genre in
                    GenreLabel(text: genre)
                        .frame(height: 35)
                }
            }.frame(height: 35)
        }
    }
}

struct GenreListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GenreListView(genreList: PreviewMocks.genreList)
                .previewLayout(.device)
            GenreListView(genreList: PreviewMocks.genreList)
                .previewLayout(.sizeThatFits)
        }
    }
}
