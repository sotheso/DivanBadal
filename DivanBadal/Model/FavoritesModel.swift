import SwiftUI
import Foundation

class SimpleFavoriteManager: ObservableObject {
    static let shared = SimpleFavoriteManager()
    @Published private(set) var favoriteIds: Set<String> = []
    private let userDefaultsKey = "FavoritePoems"
    
    init() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        if let savedIds = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            favoriteIds = Set(savedIds)
        }
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteIds), forKey: userDefaultsKey)
    }
    
    func addFavorite(_ id: String) {
        favoriteIds.insert(id)
        saveFavorites()
    }
    
    func removeFavorite(_ id: String) {
        favoriteIds.remove(id)
        saveFavorites()
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    func getFavorites() -> [String] {
        Array(favoriteIds)
    }
}

class FavoritesModel: ObservableObject {
    @Published var poems: [Poem] = []
    private let model = PoemModel()
    private let favoriteManager = SimpleFavoriteManager.shared
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        model.selectedPoet = .cervantes
        let cervantesPoems = model.readCervantesDonQuixoteData() + model.readCervantesNovelasData()
        
        model.selectedPoet = .shakespeare
        let shakespearePoems = model.readShakespeareHamletData() + model.readShakespeareMacbethData()
        
        model.selectedPoet = .keats
        let keatsPoems = model.readKeatsOdesData() + model.readKeatsEndymionData()
        
        model.selectedPoet = .dante
        let dantePoems = model.readDanteDivineComedyData() + model.readDanteVitaNuovaData()
        
        model.selectedPoet = .baudelaire
        let baudelairePoems = model.readBaudelaireFleursData() + model.readBaudelaireSpleenData()
        
        model.selectedPoet = .neruda
        let nerudaPoems = model.readNerudaVeintePoemasData() + model.readNerudaCantoGeneralData()
        
        model.selectedPoet = .garcia
        let garciaPoems = model.readGarciaLorcaBodasData() + model.readGarciaLorcaYermaData()
        
        model.selectedPoet = .valery
        let valeryPoems = model.readValeryCimetiereData() + model.readValeryCharmesData()
        
        poems = cervantesPoems + shakespearePoems + keatsPoems + dantePoems + 
                baudelairePoems + nerudaPoems + garciaPoems + valeryPoems
    }
    
    func toggleFavorite(_ poem: Poem) {
        if favoriteManager.isFavorite(poem.title) {
            favoriteManager.removeFavorite(poem.title)
        } else {
            favoriteManager.addFavorite(poem.title)
        }
    }
    
    func isFavorite(_ poem: Poem) -> Bool {
        favoriteManager.isFavorite(poem.title)
    }
    
    func getFavoritePoems() -> [Poem] {
        poems.filter { favoriteManager.isFavorite($0.title) }
    }
} 