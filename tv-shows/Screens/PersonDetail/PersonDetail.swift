//
//  SwiftUIView.swift
//  tv-shows
//
//  Created by Felipe Melo on 06/07/22.
//

import SwiftUI
import Combine

struct PersonDetailView: View {
    
    struct Constants {
        static let imageHeight: CGFloat = 250
        static let imageCorner: CGFloat = 10
    }
    
    @StateObject var viewModel: PersonDetailViewModel
    
    var body: some View {
        ScrollView {
            ZStack {
                
                ImageHeaderView(imageURL: viewModel.photo)
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: Constants.imageCorner,
                                     style: RoundedCornerStyle.continuous)
                        .fill(Color.primaryColor)
                    
                    LazyVStack(alignment: .leading,
                           spacing: DesignSystemConstants.Spacing.medium) {
                        
                        TitleText(viewModel.name)
                        
                        if viewModel.personShowsViewModel.isEmpty {
                            SubtitleText("No shows available at the moment.")
                        } else {
                            ForEach(viewModel.personShowsViewModel, id: \.self) { personShowViewModel in
                                
                                NavigationLink(destination: viewModel.navigateToShowDetailView(id: personShowViewModel.showViewModel.id)) {
                                    ShowRowView(viewModel: personShowViewModel.showViewModel)
                                }
                                
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding(DesignSystemConstants.Spacing.medium)
                    
                }
                .padding(.top,
                         Constants.imageHeight - Constants.imageCorner)
                
            }
            
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.getPersonDetail()
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let service = TVMazeServiceImpl()
        let viewModel = PersonDetailViewModel(service: service, personModel: PreviewMocks.stephenKing)
        PersonDetailView(viewModel: viewModel)
    }
}
