//
//  VerticalTextView.swift
//  tv-shows
//
//  Created by Felipe Melo on 04/07/22.
//

import SwiftUI

struct VerticalTextView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystemConstants.Spacing.veryShort) {
            DescriptionText(title)
            
            Text(value)
        }
    }
}

struct VerticalTextView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalTextView(title: "Season", value: "1")
    }
}
