//
//  SummaryText.swift
//  tv-shows
//
//  Created by Felipe Melo on 04/07/22.
//

import SwiftUI

struct SummaryText: View {
    var title: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystemConstants.Spacing.short) {
            
            TitleText(title)
            
            DescriptionText(text)
            
        }
    }
}

struct SummaryText_Previews: PreviewProvider {
    static var previews: some View {
        SummaryText(title: "Name", text: "Tom Holland")
    }
}
