//
//  EpisodeView.swift
//  tv-shows
//
//  Created by Felipe Melo on 04/07/22.
//

import SwiftUI

struct EpisodeView: View {
    
    struct Constants {
        static let imageHeight: CGFloat = 250
        static let imageCorner: CGFloat = 10
    }
    
    var viewModel: EpisodeViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                ImageHeaderView(imageURL: viewModel.image)
                
                ZStack {
                    RoundedRectangle(cornerRadius: Constants.imageCorner, style: RoundedCornerStyle.continuous)
                        .fill(Color.clearWhite)
                    
                    VStack(alignment: .leading, spacing: DesignSystemConstants.Spacing.medium) {
                        TitleText(viewModel.name)
                        
                        VStack(alignment: .leading, spacing: DesignSystemConstants.Spacing.short) {
                            RatingView(viewModel.rating)
                            
                            featureListView
                        }
                        
                        SummaryText(title: "Description", text: viewModel.summary)
                        Spacer()
                    }
                    .padding(DesignSystemConstants.Spacing.medium)
                }
                .padding(.top, Constants.imageHeight - Constants.imageCorner)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    var featureListView: some View {
        HStack {
            VerticalTextView(title: "Season", value: viewModel.season)
            
            Spacer()
            
            VerticalTextView(title: "Runtime", value: viewModel.runtime)
            
            Spacer()
            
            VerticalTextView(title: "Airdate", value: viewModel.airdate)
        }
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(viewModel: EpisodeViewModel(model: PreviewMocks.episode))
    }
}
