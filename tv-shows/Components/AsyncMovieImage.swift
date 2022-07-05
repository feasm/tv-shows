//
//  AsyncMovieImage.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI
import NukeUI
import Nuke

struct AsyncMovieImage: View {
    var imageName: String
    var width: CGFloat
    var height: CGFloat
    var isClipped: Bool
    
    @StateObject private var image = FetchImage()
    
    init(imageName: String, height: CGFloat, width: CGFloat = UIScreen.main.bounds.size.width, isClipped: Bool = true) {
        self.imageName = imageName
        self.width = width
        self.height = height
        self.isClipped = isClipped
    }
    
    var body: some View {
        ZStack {
            
            LazyImage(source: imageName) { state in
                if let image = state.image {
                    image
                } else if state.error != nil {
                    Image(systemName: "photo")
                } else {
                    ProgressView()
                }
            }
            .frame(width: width, height: height)
            .cornerRadius(10)
            .aspectRatio(contentMode: SwiftUI.ContentMode.fill)
            
        }
        .edgesIgnoringSafeArea(.top)
        .frame(width: width, height: height)
        .if(isClipped) { view in
            view.clipped()
        }
    }
}

struct AsyncMovieImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncMovieImage(imageName: "photo", height: 210, width: 142)
    }
}
