//
//  SectionView.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI
import Combine

struct SectionView: View {
    @ObservedObject var viewModel: SectionViewModel
    
    var body: some View {
        VStack(spacing: DesignSystemConstants.Spacing.medium
        ) {
            
            NavigationLink(destination: viewModel.navigateToShowListView()) {
                SectionHeaderView(viewModel.title)
                    .padding([.leading, .trailing], DesignSystemConstants.Padding.medium)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    
                    Spacer()
                        .frame(width: DesignSystemConstants.Padding.medium)
                        .border(Color.red)
                    
                    LazyHStack(spacing: DesignSystemConstants.Spacing.short) {
                        
                        ForEach(viewModel.showViewModels, id: \.self) { showViewModel in
                            
                            NavigationLink(destination: viewModel.navigateToShowDetailView(id: showViewModel.id)) {
                                ShowView(showViewModel)
                            }
                            
                        }
                    }
                    
                    Spacer()
                        .frame(width: DesignSystemConstants.Padding.medium)
                    
                }
            }
        }
        .frame(minHeight: 380)
        
    }
    
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(viewModel: PreviewMocks.movieSection)
            .previewLayout(.sizeThatFits)
    }
}
