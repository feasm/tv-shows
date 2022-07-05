//
//  RowView.swift
//  tv-shows
//
//  Created by Gustavo Minatti on 04/07/22.
//

import SwiftUI

struct RowView: View {
    let image: String
    let title: String
    let description: String
    let lightDescription: String
    let circleShape: Bool
    let imageSize: CGFloat
    
    var body: some View {
        
        HStack(spacing: DesignSystemConstants.Spacing.short) {
            
            withAnimation {
                getAsyncImage()
            }
            
            VStack(alignment: .leading,
                   spacing: DesignSystemConstants.Spacing.veryShort) {
                
                SubtitleText(title)
                
                Text(description)
                
                DescriptionText(lightDescription)
                
            }
            
        }
    }
    
    func getAsyncImage() -> AnyView {
        let image = AsyncMovieImage(imageName: image,
                                    height: imageSize,
                                    width: imageSize)
        
        if circleShape {
            return AnyView(image.clipShape(Circle()))
        } else {
            return AnyView(image)
        }
    }
}
