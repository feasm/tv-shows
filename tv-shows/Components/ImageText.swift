//
//  ImageText.swift
//  tv-shows
//
//  Created by Felipe Melo on 03/07/22.
//

import SwiftUI

struct ImageText: View {
    var image: String
    var text: String
    
    var body: some View {
        HStack(spacing: DesignSystemConstants.Spacing.veryShort) {
            
            Image(systemName: image)
            
            Text(text)
                .foregroundColor(Color.secondaryColor)
            
        }
    }
}

struct ImageText_Previews: PreviewProvider {
    static var previews: some View {
        ImageText(image: "calendar", text: "Ended")
    }
}
