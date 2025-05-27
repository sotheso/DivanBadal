//
//  IntroModel.swift
//  
//
//  Created by Sothesom on 09/10/1403.
//

import SwiftUI

enum IntroModel: String, CaseIterable{
    case page1 = "book.fill"
    case page2 = "text.book.closed.fill"
    case page3 = "person.2.fill"
    case page4 = "globe"
    
    var title: String {
        switch self {
        case .page1:
            LanguageManager.shared.localizedString(.welcome)
        case .page2:
            LanguageManager.shared.localizedString(.smartLibrary)
        case .page3:
            LanguageManager.shared.localizedString(.community)
        case .page4:
            LanguageManager.shared.localizedString(.selectLanguage)
        }
    }
    
    var subTitel: String {
        switch self {
        case .page1:
            LanguageManager.shared.localizedString(.welcomeSubtitle)
        case .page2:
            LanguageManager.shared.localizedString(.smartLibrarySubtitle)
        case .page3:
            LanguageManager.shared.localizedString(.communitySubtitle)
        case .page4:
            LanguageManager.shared.localizedString(.selectLanguageSubtitle)
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1:
            0
        case .page2:
            1
        case .page3:
            2
        case .page4:
            3
        }
    }
    
    var nextPage: IntroModel {
        let index = Int(self.index) + 1
        if index < 4 {
            return IntroModel.allCases[index]
        }
        
        return self
    }
    
    var previousPage: IntroModel {
        let index = Int(self.index) - 1
        if index >= 0 {
            return IntroModel.allCases[index]
        }
        
        return self
    }
}
