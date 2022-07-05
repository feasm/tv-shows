//
//  ShowDetailView.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI
import WebKit

struct ShowDetailView: View {
    
    struct Constants {
        static let imageHeight: CGFloat = 250
        static let imageCorner: CGFloat = 10
    }
    
    @StateObject var viewModel: ShowDetailViewModelImpl
    
    var body: some View {
        ZStack {
            
            ScrollView(showsIndicators: false) {
                
                ZStack {
                    
                    ImageHeaderView(imageURL: viewModel.imageURL)
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: Constants.imageCorner,
                                         style: RoundedCornerStyle.continuous)
                            .fill(Color.primaryColor)
                        
                        VStack(alignment: .leading,
                               spacing: DesignSystemConstants.Spacing.medium) {
                            
                            VStack(alignment: .leading,
                                   spacing: DesignSystemConstants.Spacing.short) {
                                
                                HStack {
                                    
                                    TitleText(viewModel.name)
                                    
                                    Spacer()
                                    
                                    Button {
                                        
                                        viewModel.toggleFavorite()
                                        
                                    } label: {
                                        
                                        Image(systemName: viewModel.isFavorite ? "bookmark.fill" : "bookmark")
                                            .font(.system(size: 26))
                                            .foregroundColor(viewModel.isFavorite ? .strongBlue : .secondaryColor)
                                        
                                    }
                                }
                                
                                RatingView(viewModel.rating)
                                
                                GenreListView(genreList: viewModel.genres)
                                
                                featureListView
                                
                            }
                            
                            SummaryText(title: "Schedule", text: viewModel.schedule)
                            
                            SummaryText(title: "Description", text: viewModel.summary)
                            
                            VStack {
                                
                                VStack(alignment: .leading,
                                       spacing: DesignSystemConstants.Spacing.short) {
                                    
                                    SectionHeaderView("Cast")
                                    
                                    peopleView
                                    
                                }
                                
                            }
                            
                            episodeListView
                                .animation(.none)
                            
                        }
                        .padding(DesignSystemConstants.Spacing.medium)
                        
                    }
                    .edgesIgnoringSafeArea(.top)
                    .padding(.top, Constants.imageHeight - Constants.imageCorner)
                    
                }
                
            }
            .onLoad {
                viewModel.getShow()
            }
            .animation(.easeIn)
            .edgesIgnoringSafeArea(.top)
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
    
    var featureListView: some View {
        HStack {
            VerticalTextView(title: "Type", value: viewModel.type)
            
            Spacer()
            
            VerticalTextView(title: "Language", value: viewModel.language)
            
            Spacer()
            
            VerticalTextView(title: "Status", value: viewModel.status)
        }
    }
    
    var peopleView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(alignment: .top,
                   spacing: DesignSystemConstants.Spacing.short) {
                
                ForEach(viewModel.actors,
                        id: \.self) { actorViewModel in
                    
                    VStack(spacing: DesignSystemConstants.Spacing.veryShort) {
                        
                        AsyncMovieImage(imageName: actorViewModel.photo,
                                        height: 70,
                                        width: 70)
                        
                        Text(actorViewModel.name)
                        
                    }
                    .frame(width: 70)
                    
                }
                
            }
            
        }
    }
    
    var episodeListView: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            TitleText("Episodes")
            
            Picker("Season \(viewModel.selectedSeason)", selection: $viewModel.selectedSeason) {
                
                ForEach((1...viewModel.lastSeason), id: \.self) { index in
                    Text("Season \(index)")
                }
                
            }
            
            ForEach(viewModel.episodes, id: \.self) { episodeViewModel in
                
                NavigationLink(destination: AppRouter.navigateToEpisodeView(viewModel: episodeViewModel)) {
                    
                    RowView(image: episodeViewModel.image,
                            title: episodeViewModel.name,
                            description: episodeViewModel.summary,
                            lightDescription: "",
                            circleShape: false,
                            imageSize: 100)
                    
                }
                .frame(height: 100)
                
            }
            
        }
    }
}

struct ShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.navigateToShowDetailView(id: 1)
    }
}
