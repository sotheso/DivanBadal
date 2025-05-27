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
    @StateObject private var languageManager = LanguageManager.shared
    
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn {
                IntroView1(isLoggedIn: $isLoggedIn)
                    .environmentObject(languageManager)
            } else {
                ContentView()
                    .environmentObject(languageManager)
            }
        }
    }
}
