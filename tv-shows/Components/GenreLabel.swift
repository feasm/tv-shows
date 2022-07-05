//
//  GenreLabel.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct GenreLabel: View {
    var text: String
    
    var body: some View {
        ZStack {
            
            Capsule(style: .continuous)
                .fill(Color.lightBlue)
            
            Text(text.uppercased())
                .font(.system(size: 14))
                .foregroundColor(.warmBlue)
                .bold()
                .padding([.top, .bottom], DesignSystemConstants.Spacing.veryShort)
                .padding([.leading, .trailing], DesignSystemConstants.Spacing.medium)
            
        }
    }
}

struct GenreLabel_Previews: PreviewProvider {
    static var previews: some View {
        GenreLabel(text: PreviewMocks.text)
    }
}
