//
//  ContentView.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
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
                                    MovieSectionView(viewModel: viewModel.sectionViewModels[sectionIndex-1])
                                }
                            }
                        }
                        .animation(.easeIn)
                    }
                }
                .padding([.top], DesignSystemConstants.Padding.short)
                .onAppear {
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
            
//            if viewModel.isLoading {
//                LoadingView()
//            }
        }
    }
    
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
        .accentColor(Color.strongBlack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let provider = HTTPProvider(session: URLSession.shared)
        let service = TVMazeServiceImpl(provider: provider)
        let localStorage = LocalStorageImpl()
        let viewModel = HomeViewModelImpl(service: service, localStorage: localStorage)
        
        HomeView(viewModel: viewModel)
    }
}
