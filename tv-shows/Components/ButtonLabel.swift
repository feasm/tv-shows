//
//  ButtonLabel.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct ButtonLabel: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .foregroundColor(.veryLightGray)
            .padding(8)
            .overlay(
                Capsule(style: .continuous)
                    .stroke(Color.veryLightGray, style: StrokeStyle(lineWidth: 2))
            )
    }
}

struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(text: PreviewMocks.text)
    }
}
