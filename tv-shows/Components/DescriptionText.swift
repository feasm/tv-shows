//
//  DescriptionText.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct DescriptionText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(Color.lightGray)
    }
}


struct DescriptionText_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionText(PreviewMocks.text)
    }
}
