//
//  AsyncMovieImage.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI
import NukeUI
import Nuke

struct AsyncMovieImage: View {
    var imageName: String
    var width: CGFloat
    var height: CGFloat
    var isClipped: Bool
    
    @StateObject private var image = FetchImage()
    
    init(imageName: String, height: CGFloat, width: CGFloat = UIScreen.main.bounds.size.width, isClipped: Bool = true) {
        self.imageName = imageName
        self.width = width
        self.height = height
        self.isClipped = isClipped
    }
    
    var body: some View {
        ZStack {
            LazyImage(source: imageName) { state in
                if let image = state.image {
                    image
                } else if state.error != nil {
                    Image(systemName: "photo")
                } else {
                    ProgressView()
                }
            }
            .frame(width: width, height: height)
            .cornerRadius(5)
            .aspectRatio(contentMode: SwiftUI.ContentMode.fill)
        }
        .edgesIgnoringSafeArea(.top)
        .frame(width: width, height: height)
        .if(isClipped) { view in
            view.clipped()
        }
    }
}

struct AsyncMovieImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncMovieImage(imageName: "photo", height: 210, width: 142)
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

}
