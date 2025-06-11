//
//  ContentView.swift
//  TestDiv
//
//  Created by Sothesom
//

import SwiftUI


struct ContentView: View {
    @StateObject private var settings = AppSettings()
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.colorScheme) private var systemColorScheme
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Label(languageManager.localizedString(.home), systemImage: "house.fill")
                        }
                        .tag(0)

                    SearchView()
                        .tabItem {
                            Label(languageManager.localizedString(.search), systemImage: "magnifyingglass")
                        }
                        .tag(1)

                    SettingView()
                        .tabItem {
                            Label(languageManager.localizedString(.settings), systemImage: "gearshape.fill")
                        }
                        .tag(2)
                }
                .ignoresSafeArea(.container, edges: [.leading, .trailing])
                .background(
                    Color.clear
                        .background(.ultraThinMaterial)
                        .edgesIgnoringSafeArea(.bottom)
                )
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            let threshold: CGFloat = 50
                            if gesture.translation.width > threshold {
                                // Swipe right - go to previous tab
                                withAnimation {
                                    selectedTab = max(0, selectedTab - 1)
                                }
                            } else if gesture.translation.width < -threshold {
                                // Swipe left - go to next tab
                                withAnimation {
                                    selectedTab = min(2, selectedTab + 1)
                                }
                            }
                        }
                )
            }
        }
        .environmentObject(settings)
        .environmentObject(languageManager)
        .preferredColorScheme(settings.useSystemAppearance ? nil : (settings.isDarkMode ? .dark : .light))
        .tint(settings.useSystemAppearance ? (systemColorScheme == .dark ? .white : Color("Color")) : (settings.isDarkMode ? .white : Color("Color")))
    }
}


#Preview {
    ContentView()
        .environmentObject(LanguageManager.shared)
}
