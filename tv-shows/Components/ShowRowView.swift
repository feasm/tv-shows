//
//  DetailedShowView.swift
//  tv-shows
//
//  Created by Felipe Melo on 06/07/22.
//

import SwiftUI

struct ShowRowView: View {
    let viewModel: ShowViewModel
    
    var body: some View {
        HStack(spacing: DesignSystemConstants.Spacing.short) {
            
            AsyncMovieImage(imageName: viewModel.imageURL, height: 122, width: 86)
            
            VStack(alignment: .leading,
                   spacing: DesignSystemConstants.Spacing.veryShort) {
                
                SubtitleText(viewModel.name)
                
                RatingView(viewModel.rating)
                
                GenreListView(genreList: viewModel.genres)
                
                ImageText(image: "calendar",
                          text: viewModel.status)
                
            }
            
        }
    }
}

struct ShowRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowRowView(viewModel: ShowViewModel(movie: PreviewMocks.thorShow))
    }
}
