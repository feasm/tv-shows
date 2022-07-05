//
//  PeopleView.swift
//  tv-shows
//
//  Created by Felipe Melo on 04/07/22.
//

import SwiftUI
import Combine

struct PeopleView: View {
    @StateObject var viewModel: PeopleViewModel
    
    var body: some View {
        ZStack {
            
            NavigationView {
                
                List {
                    
                    ForEach(viewModel.peopleViewModels, id: \.self) { personViewModel in
                        
                        NavigationLink(destination: viewModel.navigateToPersonDetails(id: personViewModel.id)) {
                            
                            RowView(image: personViewModel.photo,
                                    title: personViewModel.name,
                                    description: personViewModel.country,
                                    lightDescription: personViewModel.birthday,
                                    circleShape: true,
                                    imageSize: 70)
                                .padding([.top, .bottom], DesignSystemConstants.Padding.short)
                            
                        }
                        
                    }
                    
                }
                .onLoad {
                    viewModel.fetchPeople()
                }
                .listStyle(.plain)
                .navigationTitle("People")
                
            }
            .searchable(text: $viewModel.searchText)
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.navigateToPeopleView()
    }
}
