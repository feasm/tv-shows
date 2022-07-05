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
        navigationBarAppearance.backgroundColor = UIColor(named: "PrimaryColor")
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "SecondaryColor")]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "SecondaryColor")]
                       
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = UIColor(named: "SecondaryColor")
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(named: "PrimaryColor")
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            AppRouter.navigateToHomeView()
        }
    }
}
