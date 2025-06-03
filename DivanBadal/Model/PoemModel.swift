import Foundation
import SwiftUI

struct Poem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let content: String
    let vazn: String?
    let poet: PoetType
    let link1: String
    let link2: String
    
    static func == (lhs: Poem, rhs: Poem) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.content == rhs.content &&
        lhs.vazn == rhs.vazn &&
        lhs.poet == rhs.poet &&
        lhs.link1 == rhs.link1 &&
        lhs.link2 == rhs.link2
    }
}

enum PoetType: String {
    case hafez = "Hafez"
    case babaTaher = "BabaTaher"
    case saadi = "Saadi"
    case molana = "Molana"
    case cervantes = "Cervantes"
    case shakespeare = "Shakespeare"
    case keats = "Keats"
    case dante = "Dante"
    case baudelaire = "Baudelaire"
    case neruda = "Neruda"
    case garcia = "Garcia"
    case valery = "Valery"
}

// Add a new enum for poem categories
enum PoemCategory: String, CaseIterable, Identifiable {
    case hafezGhazal
    case hafezGhete
    case hafezRobaee
    case saadiGhazal
    case saadiBostan
    case molanaRobaee
    case babaTaherDoBeyti
    case masnavi
    // Add more as needed
    var id: String { self.rawValue }
    var displayName: String {
        switch self {
        case .hafezGhazal: return "Hafez Ghazals"
        case .hafezGhete: return "Hafez Poems"
        case .hafezRobaee: return "Hafez Quatrains"
        case .saadiGhazal: return "Saadi Ghazals"
        case .saadiBostan: return "Saadi Bostan"
        case .molanaRobaee: return "Molana Quatrains"
        case .babaTaherDoBeyti: return "BabaTaher 2beyti"
        case .masnavi: return "Molana Masnavi"
        }
    }
    
    var poetType: PoetType {
        switch self {
        case .hafezGhazal, .hafezGhete, .hafezRobaee:
            return .hafez
        case .saadiGhazal, .saadiBostan:
            return .saadi
        case .molanaRobaee, .masnavi:
            return .molana
        case .babaTaherDoBeyti:
            return .babaTaher
        }
    }
}

class PoemModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedPoet: PoetType = .hafez
    @Published var searchResults: [Poem] = []
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var selectedCategory: PoemCategory = .hafezGhazal
    
    var allPoems: [Poem] = []
    private let itemsPerPage = 10
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        switch selectedCategory {
        case .hafezGhazal:
            allPoems = readHafezData()
        case .hafezGhete:
            allPoems = readHafezGheteData()
        case .hafezRobaee:
            allPoems = readHafezRobaeeData()
        case .saadiGhazal:
            allPoems = readSaadiQazalData()
        case .saadiBostan:
            allPoems = readSaadiBostanData()
        case .molanaRobaee:
            allPoems = readMolanaRobaeeData()
        case .babaTaherDoBeyti:
            allPoems = readBabaTaherData()
        case .masnavi:
            allPoems = readMasnaviData()
        }
        search()
    }
    
    func search() {
        let filteredPoems = if searchText.isEmpty {
            allPoems
        } else {
            allPoems.filter { poem in
                poem.title.contains(searchText) ||
                poem.content.contains(searchText) ||
                (poem.vazn?.contains(searchText) ?? false)
            }
        }
        
        // نمایش 10 آیتم اول
        searchResults = Array(filteredPoems.prefix(itemsPerPage))
        currentPage = 1
    }
    
    func loadMoreContent() {
        guard !isLoading else { return }
        
        isLoading = true
        
        // شبیه‌سازی تاخیر شبکه
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let filteredPoems = if self.searchText.isEmpty {
                self.allPoems
            } else {
                self.allPoems.filter { poem in
                    poem.title.contains(self.searchText) ||
                    poem.content.contains(self.searchText) ||
                    (poem.vazn?.contains(self.searchText) ?? false)
                }
            }
            
            let startIndex = self.currentPage * self.itemsPerPage
            let endIndex = min(startIndex + self.itemsPerPage, filteredPoems.count)
            
            if startIndex < filteredPoems.count {
                self.searchResults.append(contentsOf: filteredPoems[startIndex..<endIndex])
                self.currentPage += 1
            }
            
            self.isLoading = false
        }
    }
    
    func switchPoet() {
        selectedPoet = selectedPoet == .hafez ? .babaTaher : .hafez
        loadPoems()
    }
    
    func readHafezData() -> [Poem] {
        // خواندن داده‌های حافظ از JSON
        guard let url = Bundle.main.url(forResource: "HafezQazal", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(
                title: title,
                content: content,
                vazn: item["vazn"] as? String,
                poet: .hafez,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readBabaTaherData() -> [Poem] {
        // خواندن داده‌های باباطاهر از JSON
        guard let url = Bundle.main.url(forResource: "BabaTaher2B", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(
                title: title,
                content: content,
                vazn: item["vazn"] as? String,
                poet: .babaTaher,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readHafezGheteData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "HafezGhete", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(
                title: title,
                content: content,
                vazn: item["vazn"] as? String,
                poet: .hafez,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readHafezRobaeeData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "HafezRobaee", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(
                title: title,
                content: content,
                vazn: item["vazn"] as? String,
                poet: .hafez,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readSaadiQazalData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "SaadiQazal", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(
                title: title,
                content: content,
                vazn: item["vazn"] as? String,
                poet: .saadi,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readSaadiBostanData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "Saad‌iBostan", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(
                title: title,
                content: content,
                vazn: item["vazn"] as? String,
                poet: .saadi,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readMolanaRobaeeData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "DivnanShamsRobaee", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(
                title: title,
                content: content,
                vazn: item["vazn"] as? String,
                poet: .molana,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readMasnaviData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "masnavi", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(
                title: title,
                content: content,
                vazn: item["vazn"] as? String,
                poet: .molana,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func allFavoritePoems(_ favoriteIds: [String]) -> [Poem] {
        var poems: [Poem] = []
        
        // Check Hafez poems
        selectedPoet = .hafez
        loadPoems()
        poems.append(contentsOf: allPoems.filter { favoriteIds.contains($0.title) })
        
        // Check Baba Taher poems
        selectedPoet = .babaTaher
        loadPoems()
        poems.append(contentsOf: allPoems.filter { favoriteIds.contains($0.title) })
        
        return poems
    }
} 
