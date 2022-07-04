//
//  ShowView.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct ShowView: View {
    var viewModel: ShowViewModel
    
    init(_ viewModel: ShowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: DesignSystemConstants.Spacing.short) {
            AsyncMovieImage(imageName: viewModel.imageURL, height: 210, width: 142)
                .shadow(radius: 10)
            
            SubtitleText(viewModel.name)
            
            RatingView(viewModel.rating)
            
            Spacer()
        }
        .frame(width: 142)
    }
}

struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowView(ShowViewModel(movie: PreviewMocks.thorMovie))
            .previewLayout(.sizeThatFits)
    }
}
