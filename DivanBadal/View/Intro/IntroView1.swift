//
//  IntroView1.swift
//  
//
//  Created by Sothesom
//

import SwiftUI

struct IntroView1: View {
    
    @State private var showingLoginView = false
    @State private var activePage: IntroModel = .page1
    @State private var selectedLanguage: String? = nil
    @Binding var isLoggedIn: Bool
    @EnvironmentObject private var languageManager: LanguageManager
    
    let languages = ["Türkçe", "English"]
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                
                VStack {
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)

                    IntroSymbolView(symbol: activePage.rawValue, config: .init(font: .system(size: 150, weight: .bold), frame: .init(width: 250, height: 200), radio:30, forgroudColor: .white))
                    
                    TexContents(size: size)
                    
                    if activePage == .page4 {
                        LanguageSelectionView(selectedLanguage: $selectedLanguage, languages: languages)
                            .padding(.vertical, 20)
                    }
                    
                    Spacer(minLength: 0)
                    IndicatorView()
                        .padding(.bottom)
                    
                    ContinueButton()
                    
                    if activePage == .page4 {
                        PrivacyPolicyButton()
                    }
                    
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HeaderView()
                }
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            let threshold: CGFloat = 50
                            if gesture.translation.width > threshold {
                                // Swipe right - go to previous page
                                if activePage != .page1 {
                                    withAnimation(.spring(duration: 0.5)) {
                                        activePage = activePage.previousPage
                                    }
                                }
                            } else if gesture.translation.width < -threshold {
                                // Swipe left - go to next page
                                if activePage != .page4 {
                                    withAnimation(.spring(duration: 0.5)) {
                                        activePage = activePage.nextPage
                                    }
                                }
                            }
                        }
                )
            }
            .background{
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color("Color intro2"),
                                Color("Color intro1")
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .ignoresSafeArea()
            }
        }
        .localized()
    }
    
    @ViewBuilder
    func TexContents(size: CGSize) -> some View {
        VStack(spacing: 8){
            HStack(alignment: .top, spacing: 0){
                ForEach(IntroModel.allCases, id: \.rawValue){ page in
                    Text(page.title)
                        .lineLimit(1)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
                        .foregroundStyle(.white)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.spring(duration: 0.7, bounce: 0.2), value: activePage)
            
            HStack(alignment: .top, spacing: 0){
                ForEach(IntroModel.allCases, id: \.rawValue){ page in
                    Text(page.subTitel)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(width: size.width)
                        .foregroundStyle(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.spring(duration: 0.7, bounce: 0.2), value: activePage)
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    @ViewBuilder
    func IndicatorView() -> some View{
        HStack(spacing: 6){
            ForEach(IntroModel.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
        .padding(.bottom, 12)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button {
                withAnimation(.spring(duration: 0.5)) {
                    activePage = activePage.previousPage
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
                    .padding(10)
                    .background {
                        Circle()
                            .fill(Material.ultraThinMaterial)
                    }
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button("Skip") {
                withAnimation(.spring(duration: 0.5)) {
                    activePage = .page4
                }
            }
            .fontWeight(.semibold)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background {
                Capsule()
                    .fill(Material.ultraThinMaterial)
            }
            .opacity(activePage != .page4 ? 1 : 0)
        }
        .foregroundStyle(.white)
        .animation(.spring(duration: 0.5), value: activePage)
        .padding(15)
    }
    
    @ViewBuilder
    func LanguageSelectionView(selectedLanguage: Binding<String?>, languages: [String]) -> some View {
        VStack(spacing: 15) {
            ForEach(languages, id: \.self) { language in
                LanguageButton(
                    language: language,
                    isSelected: selectedLanguage.wrappedValue == language,
                    action: {
                        selectedLanguage.wrappedValue = language
                        languageManager.currentLanguage = language
                    }
                )
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func LanguageButton(language: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(language)
                    .font(.title3)
                    .foregroundStyle(isSelected ? .white : .white.opacity(0.3))
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? 
                        AnyShapeStyle(Material.ultraThinMaterial) : 
                        AnyShapeStyle(Color("Color intro2").opacity(0.3)))
                    .overlay {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            .white.opacity(0.5),
                                            .clear,
                                            .white.opacity(0.2),
                                            .clear
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    func ContinueButton() -> some View {
        Button {
            if activePage == .page4 {
                if selectedLanguage != nil {
                    isLoggedIn = true
                }
            } else {
                activePage = activePage.nextPage
            }
        } label: {
            Text(activePage == .page4 ? "Start" : "Continue")
                .contentTransition(.identity)
                .foregroundStyle(activePage == .page4 && selectedLanguage == nil ? .white.opacity(0.3) : .white)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .frame(maxWidth: 370)
                .background {
                    if activePage == .page4 && selectedLanguage == nil {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Color intro2").opacity(0.3))
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.ultraThinMaterial)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        LinearGradient(
                                            colors: [
                                                .white.opacity(0.5),
                                                .clear,
                                                .white.opacity(0.2),
                                                .clear
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            }
                    }
                }
        }
        .disabled(activePage == .page4 && selectedLanguage == nil)
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
    
    @ViewBuilder
    func PrivacyPolicyButton() -> some View {
        Link(destination: URL(string: "https://sotheso.github.io/DivanBadal-Privacy-Policy/privacy-policy.html")!) {
            HStack(spacing: 8) {
                Image(systemName: "lock.shield.fill")
                    .foregroundColor(.white.opacity(0.8))
                Text("Privacy Policy")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.footnote)
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    IntroView1(isLoggedIn: .constant(false))
        .environmentObject(LanguageManager.shared)
}
