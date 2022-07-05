//
//  RatingView.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct RatingView: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            
            Image(systemName: "star.fill")
                .renderingMode(.original)
            
            DescriptionText(text)
            
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(PreviewMocks.text)
    }
}
