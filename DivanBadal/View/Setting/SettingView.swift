//
//  SettingView.swift
//  TestDiv
//
//  Created by Sothesom
//

import SwiftUI
import CoreData
import Foundation

struct SettingView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject private var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Color Back")
                    .ignoresSafeArea()
                
                List {
                    Section(header: Text(languageManager.localizedString(.appearance))) {
                        Toggle(isOn: Binding(
                            get: { appSettings.isDarkMode },
                            set: { newValue in
                                appSettings.isDarkMode = newValue
                                appSettings.saveSettings()
                            }
                        )) {
                            Label(languageManager.localizedString(.darkMode), systemImage: "moon.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                    
                    Section(header: Text(languageManager.localizedString(.personalization))) {
                        NavigationLink(destination: FavoritePoetsView(poets: Poet.samplePoets)) {
                            Label(languageManager.localizedString(.favoritePoets), systemImage: "heart.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                    
                    Section(header: Text(languageManager.localizedString(.language))) {
                        ForEach(["Türkçe", "English"], id: \.self) { language in
                            HStack {
                                Label(language, 
                                      systemImage: language == "English" ? "e.square" : "t.square")
                                    .foregroundStyle(Color("Color"))
                                Spacer()
                                if languageManager.currentLanguage == language {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(Color("Color"))
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                languageManager.currentLanguage = language
                            }
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                    
                    Section(header: Text(languageManager.localizedString(.about))) {
                        NavigationLink(destination: AboutUsView()) {
                            Label(languageManager.localizedString(.about), systemImage: "info.circle.fill")
                                .foregroundStyle(Color("Color"))
                        }
                        
                        Link(destination: URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review")!) {
                            Label(languageManager.localizedString(.rateApp), systemImage: "star.fill")
                                .foregroundStyle(Color("Color"))
                        }
                        
                        Link(destination: URL(string: "https" + "://sotheso.github.io/DivanBadal-Privacy-Policy/privacy-policy.html")!) {
                            Label("Privacy Policy", systemImage: "lock.shield.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                }
                .scrollContentBackground(.hidden)
            }
            .tint(Color("Color"))
            .overlay(
                VStack {
                    Spacer()
                    FooterText()
                }
                .padding(.bottom, 20)
            )
            .localized()
        }
    }
}

struct FooterText: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Text(languageManager.localizedString(.developedBy))
                    .foregroundColor(.gray)
                    .font(.footnote)
                
                Link("Sothesom", destination: URL(string: "https://t.me/sothesom")!)
                    .foregroundColor(colorScheme == .dark ? .white : Color("Color"))
                    .font(.footnote)
            }
            Text("\(languageManager.localizedString(.appVersion)): 0.0.1")
                .foregroundColor(.gray)
                .font(.footnote)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    SettingView()
        .environmentObject(AppSettings())
        .environmentObject(LanguageManager.shared)
}
