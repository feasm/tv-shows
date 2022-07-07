//
//  ShowListView.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import SwiftUI

struct ShowListView: View {
    @StateObject var viewModel: ShowListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.filteredShowViewModels, id: \.self) { viewModel in
                
                NavigationLink(destination: AppRouter.navigateToShowDetailView(id: viewModel.id)) {
                    RowView(image: viewModel.imageURL,
                            title: viewModel.name,
                            description: viewModel.summary,
                            lightDescription: "",
                            circleShape: false,
                            imageSize: 100)
                        .padding([.top, .bottom], DesignSystemConstants.Padding.medium)
                        .frame(height: 100)
                    
                }
                
            }
            
        }
        .padding([.top, .bottom], DesignSystemConstants.Padding.short)
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText)
        .navigationTitle(viewModel.title)
    }
}

struct ShowListView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.navigateToShowListView(viewModels: [ShowViewModel(show: PreviewMocks.thorShow)], title: "Favorites")
    }
}
