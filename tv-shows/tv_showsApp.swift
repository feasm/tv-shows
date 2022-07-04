//
//  tv_showsApp.swift
//  tv-shows
//
//  Created by Felipe Melo on 01/07/22.
//

import SwiftUI

@main
struct tv_showsApp: App {
    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
                       
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = .black
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            AppRouter.navigateToHomeView()
        }
    }
}
