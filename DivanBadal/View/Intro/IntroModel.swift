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
            "Welcome to Divan"
        case .page2:
            "Meet European Poets"
        case .page3:
            "Biographies & Works"
        case .page4:
            "Select App Language"
        }
    }
    
    var subTitel: String {
        switch self {
        case .page1:
            "Experience the best reading journey with Divan"
        case .page2:
            "Discover the lives and legacies of Europe's most influential poets. From their early years to their greatest works."
        case .page3:
            "Access detailed biographies and explore the major works of each poet. Save your favorite poets and build your personal collection of literary knowledge."
        case .page4:
            "Please select your preferred language"
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
