//
//  DivanBadalApp.swift
//  DivanBadal
//
//  Created by Sothesom on 04/03/1404.
//

import SwiftUI

@main
struct DivanBadalApp: App {
    @State private var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn {
                IntroView1(isLoggedIn: $isLoggedIn)
            } else {
                ContentView()
            }
        }
    }
}
