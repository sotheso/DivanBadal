//
//  DivanBadalApp.swift
//  DivanBadal
//
//  Created by Sothesom
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
