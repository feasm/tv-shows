//
//  ProgressView.swift
//  tv-shows
//
//  Created by Felipe Melo on 04/07/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.clearWhite
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.strongBlack))
                .scaleEffect(2)
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
