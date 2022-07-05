//
//  SearchView.swift
//  tv-shows
//
//  Created by Felipe Melo on 03/07/22.
//

import SwiftUI
import Combine

struct SearchView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            
            LazyVStack(alignment: .leading,
                       spacing: DesignSystemConstants.Spacing.short) {
                
                    ForEach(viewModel.filteredShowViewModels,
                            id: \.self) { showViewModel in
                        
                        searchedShowView(showViewModel)
                        
                    }
                
            }
            
        }
    }
    
    fileprivate func searchedShowView(_ showViewModel: ShowViewModel) -> AnyView {
        return AnyView(
            
            NavigationLink(destination: viewModel.navigateToShowDetailView(id: showViewModel.id)) {
                
                HStack(spacing: DesignSystemConstants.Spacing.short) {
                    
                    AsyncMovieImage(imageName: showViewModel.imageURL, height: 122, width: 86)
                    
                    VStack(alignment: .leading,
                           spacing: DesignSystemConstants.Spacing.veryShort) {
                        
                        SubtitleText(showViewModel.name)
                        
                        RatingView(showViewModel.rating)
                        
                        GenreListView(genreList: showViewModel.genres)
                        
                        ImageText(image: "calendar",
                                  text: showViewModel.status)
                        
                    }
                    
                }
                .padding(.leading, DesignSystemConstants.Padding.medium)
                
            }
            
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let provider = HTTPProvider(session: URLSession.shared)
        let service = TVMazeServiceImpl(provider: provider)
        let localStorage = LocalStorageImpl()
        let viewModel = HomeViewModel(service: service, localStorage: localStorage)
        
        SearchView(viewModel: viewModel)
    }
}
