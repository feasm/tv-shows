//
//  LazyScrollView.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

struct LazyScrollView<Content: View>: View {
    let axis: Axis.Set
    let spacing: CGFloat
    @ViewBuilder var content: () -> Content
    
    init(_ axis: Axis.Set, spacing: CGFloat = 0, _ content: @escaping () -> Content) {
        self.axis = axis
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        ScrollView(axis, showsIndicators: false) {
            if axis == .vertical {
                LazyVStack(spacing: spacing) {
                    content()
                }
            } else {
                LazyHStack(spacing: spacing) {
                    content()
                }
            }
        }
    }
}

struct LazyScrollView_Previews: PreviewProvider {
    static var previews: some View {
        LazyScrollView(.vertical,
                       spacing: DesignSystemConstants.Spacing.short) {
            SectionView(viewModel: PreviewMocks.movieSection)
        }
    }
}
