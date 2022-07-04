//
//  ImageHeaderView.swift
//  tv-shows
//
//  Created by Felipe Melo on 04/07/22.
//

import SwiftUI

struct ImageHeaderView: View {
    let imageHeight: CGFloat = 250
    let imageURL: String
    
    var body: some View {
        VStack {
            if !imageURL.isEmpty {
                AsyncMovieImage(imageName: imageURL, height: imageHeight, isClipped: false)
            }
            
            Spacer()
        }
    }
}

struct ImageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageHeaderView(imageURL: "photo")
    }
}
