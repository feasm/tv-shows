//
//  TitleText.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct TitleText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 28))
            .bold()
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(PreviewMocks.movieSection.title)
    }
}
