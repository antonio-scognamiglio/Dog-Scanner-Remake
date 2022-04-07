//
//  Dog_Scanner_RemakeApp.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 14/12/21.
//

import SwiftUI

@main
struct Dog_Scanner_RemakeApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
				.environmentObject(DogStore())
        }
    }
}
