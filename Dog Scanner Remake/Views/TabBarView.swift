//
//  TabBarView.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 14/12/21.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var dogStore: DogStore
    
    init() {
        let tabBarAppeareance = UITabBarAppearance()
        tabBarAppeareance.shadowColor = .gray
        tabBarAppeareance.backgroundColor = .systemGray5
        UITabBar.appearance().standardAppearance = tabBarAppeareance

    }
        var body: some View {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Scan", systemImage: "camera")
                    }

                
                ContentView()
                    .tabItem {
                        Label("History", systemImage: "clock")
                    }
                
                ContentView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
            .accentColor(.mint)
        }
    }


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
