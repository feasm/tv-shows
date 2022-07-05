//
//  Colors+extensions.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

extension Color {
    static var primaryColor: Color {
        Color("PrimaryColor")
    }
    
    static var secondaryColor: Color {
        Color("SecondaryColor")
    }
    
    static var lightGray: Color {
        Color(red: 160, green: 160, blue: 160)
    }
    
    static var veryLightGray: Color {
        Color(red: 190, green: 190, blue: 190)
    }
    
    static var lightBlue: Color {
        Color(red: 218, green: 225, blue: 251)
    }
    
    static var warmBlue: Color {
        Color(red: 133, green: 156, blue: 208)
    }
    
    static var strongBlue: Color {
        Color(uiColor: .blue)
    }
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat = 1) {
        self.init(RGBColorSpace.sRGB, red: red/255, green: green/255, blue: blue/255, opacity: 1)
    }
}
