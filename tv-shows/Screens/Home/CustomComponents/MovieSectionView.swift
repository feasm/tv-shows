//
//  MovieSectionView.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI
import Combine

struct MovieSectionView: View {
    @StateObject var viewModel: SectionViewModel
    
    var body: some View {
        VStack(spacing: DesignSystemConstants.Spacing.medium
        ) {
            MovieSectionHeaderView(viewModel.title)
                .padding([.leading, .trailing], DesignSystemConstants.Padding.medium)
            
            GeometryReader { geo in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Spacer()
                            .frame(width: DesignSystemConstants.Padding.medium)
                            .border(Color.red)
                        
                        HStack(spacing: DesignSystemConstants.Spacing.short) {
                            ForEach(viewModel.filteredShowViewModels, id: \.self) { showViewModel in
//                                NavigationLink(destination: ShowDetailView(viewModel.selectedMovie), tag: "ShowDetailView", selection: $router) {}
                                NavigationLink(destination: viewModel.navigateToShowDetailView(id: showViewModel.id)) {
                                    ShowView(showViewModel)
                                }
                            }
                        }
                        
                        Spacer()
                            .frame(width: DesignSystemConstants.Padding.medium)
                    }
                    .background(GeometryReader { geo -> Color in
                                    DispatchQueue.main.async {
                                        let scrollContentSizeX = geo.size.width
                                        let offsetX = -geo.frame(in: .named("scroll")).origin.x
                                        
                                        if scrollContentSizeX - offsetX < 500 {
                                            viewModel.updateShows()
                                        }
                                    }
                                    return Color.clear
                                })
                }.coordinateSpace(name: "scroll")
            }
        }
        .frame(minHeight: 380)
    }
    
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(viewModel: PreviewMocks.movieSection)
        .previewLayout(.sizeThatFits)
    }
}

struct MovieSectionHeaderView: View {
    var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            TitleText(title)
            
            Spacer()
            
            ButtonLabel(text: "See more")
        }
    }
}
