//
//  SubtitleText.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct SubtitleText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(.secondaryColor)
            .font(.system(size: 20))
            .bold()
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct SubtitleText_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleText(PreviewMocks.text)
    }
}
