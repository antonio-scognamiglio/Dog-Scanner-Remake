//
//  TabBarView.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 14/12/21.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var dogStore: DogStore // ho il dubbio se ci vuole pure qui, nel dubbio lo metto
    
    init() {
        let tabBarAppeareance = UITabBarAppearance()
        tabBarAppeareance.shadowColor = .gray // For line separator of the tab bar
        tabBarAppeareance.backgroundColor = .systemGray5 // For background color
        UITabBar.appearance().standardAppearance = tabBarAppeareance
//        UITabBar.appearance().backgroundColor = .systemMint
//        questa serve per cambiare il colore della tab bar
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
        //ho provato a mettere il modificatore .environment e passargli DogStore, ma dà errore boh...
    }
}
