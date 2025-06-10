//
//  ContentView.swift
//  TestDiv
//
//  Created by Sothesom on 25/01/1404.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var settings = AppSettings()
    @StateObject private var languageManager = LanguageManager.shared

    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    HomeView()
                        .tabItem {
                            Label(languageManager.localizedString(.home), systemImage: "house.fill")
                        }

                    SearchView()
                        .tabItem {
                            Label(languageManager.localizedString(.search), systemImage: "magnifyingglass")
                        }


                    SettingView()
                        .tabItem {
                            Label(languageManager.localizedString(.settings), systemImage: "gearshape.fill")
                        }
                }
                .ignoresSafeArea(.container, edges: [.leading, .trailing])
                .background(
                    Color.clear
                        .background(.ultraThinMaterial)
                        .edgesIgnoringSafeArea(.bottom)
                )
            }
        }
        .environmentObject(settings)
        .environmentObject(languageManager)
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .tint(settings.isDarkMode ? .white : Color("Color"))
    }
}


#Preview {
    ContentView()
        .environmentObject(LanguageManager.shared)
}
