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
                        
                        NavigationLink(destination: viewModel.navigateToShowDetailView(id: showViewModel.id)) {
                            
                            ShowRowView(viewModel: showViewModel)
                                .padding(.leading, DesignSystemConstants.Padding.medium)
                            
                        }
                        
                    }
                
            }
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let service = TVMazeServiceImpl()
        let localStorage = LocalStorageImpl()
        let viewModel = HomeViewModel(service: service, localStorage: localStorage)
        
        SearchView(viewModel: viewModel)
    }
}
