//
//  IntroView1.swift
//  
//
//  Created by Sothesom on 09/10/1403.
//

import SwiftUI

struct IntroView1: View {
    
    @State private var showingLoginView = false
    @State private var activePage: IntroModel = .page1
    @State private var selectedLanguage: String? = nil
    @Binding var isLoggedIn: Bool
    @EnvironmentObject private var languageManager: LanguageManager
    
    let languages = ["فارسی", "English"]
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                
                VStack {
                    Spacer(minLength: 0)
                    IntroSymbolView(symbol: activePage.rawValue, config: .init(font: .system(size: 150, weight: .bold), frame: .init(width: 250, height: 200), radio:30, forgroudColor: .white))
                    
                    TexContents(size: size)
                    
                    if activePage == .page4 {
                        LanguageSelectionView(selectedLanguage: $selectedLanguage, languages: languages)
                            .padding(.vertical, 20)
                    }
                    
                    Spacer(minLength: 0)
                    
                    IndicatorView()
                    
                    ContinueButton()
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HeaderView()
                }
            }
            .background{
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.1, green: 0.1, blue: 0.2),
                                Color(red: 0.2, green: 0.3, blue: 0.5)
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
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button(LanguageManager.shared.localizedString(.skip)) {
                withAnimation(.spring(duration: 0.5)) {
                    activePage = .page4
                }
            }
            .fontWeight(.semibold)
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
                Button {
                    selectedLanguage.wrappedValue = language
                    languageManager.currentLanguage = language
                } label: {
                    HStack {
                        Text(language)
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        if selectedLanguage.wrappedValue == language {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedLanguage.wrappedValue == language ? Color.white : Color.white.opacity(0.3), lineWidth: 2)
                    )
                }
            }
        }
        .padding(.horizontal)
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
            Text(activePage == .page4 ? LanguageManager.shared.localizedString(.start) : LanguageManager.shared.localizedString(.continueButton))
                .contentTransition(.identity)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .frame(maxWidth: 370)
                .background(activePage == .page4 && selectedLanguage == nil ? Color.gray : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .disabled(activePage == .page4 && selectedLanguage == nil)
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
}

#Preview {
    IntroView1(isLoggedIn: .constant(false))
        .environmentObject(LanguageManager.shared)
}
