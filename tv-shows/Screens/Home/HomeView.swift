//
//  ContentView.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        TabView {
            
            homeView
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            AppRouter.navigateToPeopleView()
                .tabItem {
                    Label("People", systemImage: "person")
                }
            
        }
        .accentColor(Color.secondaryColor)
    }
    
    var homeView: some View {
        ZStack {
            
            NavigationView {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    if viewModel.hasSearchResults {
                        
                        viewModel.navigateToSearchView()
                        
                    } else {
                        
                        LazyVStack(spacing: DesignSystemConstants.Spacing.high) {
                            
                            if viewModel.sectionViewModels.count > 0 {
                                
                                ForEach((1...viewModel.sectionViewModels.count), id: \.self) { sectionIndex in
                                    
                                    SectionView(viewModel: viewModel.sectionViewModels[sectionIndex-1])
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                .padding([.top], DesignSystemConstants.Padding.short)
                .onAppear {
                    withAnimation {
                        viewModel.updateFavorites()
                    }
                }
                .onLoad {
                    viewModel.fetchShows()
                }
                .navigationTitle("Home")
            }
            .searchable(text: $viewModel.searchText) {
                // TODO: Add search suggestions
            }
            .onSubmit(of: .search, {
                withAnimation {
                    viewModel.searchShows()
                }
            })
            .onChange(of: viewModel.searchText) { _ in
                withAnimation {
                    viewModel.clearSearch()
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter.navigateToHomeView()
    }
}
