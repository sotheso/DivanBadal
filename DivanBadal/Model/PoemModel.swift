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
    // Foreign poets categories
    case cervantesDonQuixote
    case cervantesNovelas
    case shakespeareHamlet
    case shakespeareMacbeth
    case keatsOdes
    case keatsEndymion
    case danteDivineComedy
    case danteVitaNuova
    case baudelaireFleurs
    case baudelaireSpleen
    case nerudaVeintePoemas
    case nerudaCantoGeneral
    case garciaLorcaBodas
    case garciaLorcaYerma
    case valeryCimetiere
    case valeryCharmes
    
    var id: String { self.rawValue }
    var displayName: String {
        switch self {
        // Foreign poets display names
        case .cervantesDonQuixote: return "Don Quixote"
        case .cervantesNovelas: return "Exemplary Novels"
        case .shakespeareHamlet: return "Hamlet"
        case .shakespeareMacbeth: return "Macbeth"
        case .keatsOdes: return "Keats' Odes"
        case .keatsEndymion: return "Endymion"
        case .danteDivineComedy: return "Divine Comedy"
        case .danteVitaNuova: return "La Vita Nuova"
        case .baudelaireFleurs: return "Les Fleurs du mal"
        case .baudelaireSpleen: return "Le Spleen de Paris"
        case .nerudaVeintePoemas: return "Twenty Love Poems"
        case .nerudaCantoGeneral: return "Canto General"
        case .garciaLorcaBodas: return "Blood Wedding"
        case .garciaLorcaYerma: return "Yerma"
        case .valeryCimetiere: return "Le Cimetière marin"
        case .valeryCharmes: return "Charmes"
        }
    }
    
    var poetType: PoetType {
        switch self {
        case .cervantesDonQuixote, .cervantesNovelas:
            return .cervantes
        case .shakespeareHamlet, .shakespeareMacbeth:
            return .shakespeare
        case .keatsOdes, .keatsEndymion:
            return .keats
        case .danteDivineComedy, .danteVitaNuova:
            return .dante
        case .baudelaireFleurs, .baudelaireSpleen:
            return .baudelaire
        case .nerudaVeintePoemas, .nerudaCantoGeneral:
            return .neruda
        case .garciaLorcaBodas, .garciaLorcaYerma:
            return .garcia
        case .valeryCimetiere, .valeryCharmes:
            return .valery
        }
    }
}

class PoemModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedPoet: PoetType = .cervantes
    @Published var searchResults: [Poem] = []
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var selectedCategory: PoemCategory = .cervantesDonQuixote
    
    var allPoems: [Poem] = []
    private let itemsPerPage = 10
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        switch selectedCategory {
        // Foreign poets cases
        case .cervantesDonQuixote:
            allPoems = readCervantesDonQuixoteData()
        case .cervantesNovelas:
            allPoems = readCervantesNovelasData()
        case .shakespeareHamlet:
            allPoems = readShakespeareHamletData()
        case .shakespeareMacbeth:
            allPoems = readShakespeareMacbethData()
        case .keatsOdes:
            allPoems = readKeatsOdesData()
        case .keatsEndymion:
            allPoems = readKeatsEndymionData()
        case .danteDivineComedy:
            allPoems = readDanteDivineComedyData()
        case .danteVitaNuova:
            allPoems = readDanteVitaNuovaData()
        case .baudelaireFleurs:
            allPoems = readBaudelaireFleursData()
        case .baudelaireSpleen:
            allPoems = readBaudelaireSpleenData()
        case .nerudaVeintePoemas:
            allPoems = readNerudaVeintePoemasData()
        case .nerudaCantoGeneral:
            allPoems = readNerudaCantoGeneralData()
        case .garciaLorcaBodas:
            allPoems = readGarciaLorcaBodasData()
        case .garciaLorcaYerma:
            allPoems = readGarciaLorcaYermaData()
        case .valeryCimetiere:
            allPoems = readValeryCimetiereData()
        case .valeryCharmes:
            allPoems = readValeryCharmesData()
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
        selectedPoet = selectedPoet == .cervantes ? .shakespeare : .cervantes
        loadPoems()
    }
    
    func readCervantesDonQuixoteData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "DonQuixote", withExtension: "json"),
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
                poet: .cervantes,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readCervantesNovelasData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "Novelas", withExtension: "json"),
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
                poet: .cervantes,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readShakespeareHamletData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "Hamlet", withExtension: "json"),
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
                poet: .shakespeare,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readShakespeareMacbethData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "Macbeth", withExtension: "json"),
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
                poet: .shakespeare,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readKeatsOdesData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "KeatsOdes", withExtension: "json"),
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
                poet: .keats,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readKeatsEndymionData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "Endymion", withExtension: "json"),
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
                poet: .keats,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readDanteDivineComedyData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "DivineComedy", withExtension: "json"),
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
                poet: .dante,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readDanteVitaNuovaData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "VitaNuova", withExtension: "json"),
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
                poet: .dante,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readBaudelaireFleursData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "FleursDuMal", withExtension: "json"),
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
                poet: .baudelaire,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readBaudelaireSpleenData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "SpleenDeParis", withExtension: "json"),
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
                poet: .baudelaire,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readNerudaVeintePoemasData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "VeintePoemas", withExtension: "json"),
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
                poet: .neruda,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readNerudaCantoGeneralData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "CantoGeneral", withExtension: "json"),
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
                poet: .neruda,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readGarciaLorcaBodasData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "BodasDeSangre", withExtension: "json"),
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
                poet: .garcia,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readGarciaLorcaYermaData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "Yerma", withExtension: "json"),
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
                poet: .garcia,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readValeryCimetiereData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "CimetiereMarin", withExtension: "json"),
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
                poet: .valery,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func readValeryCharmesData() -> [Poem] {
        guard let url = Bundle.main.url(forResource: "Charmes", withExtension: "json"),
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
                poet: .valery,
                link1: item["link1"] as? String ?? "",
                link2: item["link2"] as? String ?? ""
            )
        }
    }
    
    func allFavoritePoems(_ favoriteIds: [String]) -> [Poem] {
        var poems: [Poem] = []
        
        // Check Cervantes poems
        selectedPoet = .cervantes
        loadPoems()
        poems.append(contentsOf: allPoems.filter { favoriteIds.contains($0.title) })
        
        // Check Shakespeare poems
        selectedPoet = .shakespeare
        loadPoems()
        poems.append(contentsOf: allPoems.filter { favoriteIds.contains($0.title) })
        
        return poems
    }
} 
