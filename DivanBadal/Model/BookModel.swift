import SwiftUI

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let imageName: String
    let description: String
    let poetType: PoetType
    let category: PoemCategory
    let year: Int
}

class BookModel: ObservableObject {
    @Published var books: [Book] = []
    private let bookImages = ["Book1", "Book2", "Book3", "Book4", "Book5", "Book6"]
    
    init() {
        loadBooks()
    }
    
    private func getBookImage(for index: Int) -> String {
        return bookImages[index % bookImages.count]
    }
    
    func loadBooks() {
        var loadedBooks: [Book] = []
        
        // Load books based on PoemCategory
        for category in PoemCategory.allCases {
            let jsonFileName: String
            switch category {
            case .hafezGhazal: jsonFileName = "HafezQazal"
            case .hafezGhete: jsonFileName = "HafezGhete"
            case .hafezRobaee: jsonFileName = "HafezRobaee"
            case .saadiGhazal: jsonFileName = "SaadiQazal"
            case .saadiBostan: jsonFileName = "Saad‌iBostan"
            case .molanaRobaee: jsonFileName = "DivnanShamsRobaee"
            case .babaTaherDoBeyti: jsonFileName = "BabaTaher2B"
            case .masnavi: jsonFileName = "masnavi"
            // New books for foreign poets
            case .cervantesDonQuixote: jsonFileName = "DonQuixote"
            case .cervantesNovelas: jsonFileName = "Novelas"
            case .shakespeareHamlet: jsonFileName = "Hamlet"
            case .shakespeareMacbeth: jsonFileName = "Macbeth"
            case .keatsOdes: jsonFileName = "KeatsOdes"
            case .keatsEndymion: jsonFileName = "Endymion"
            case .danteDivineComedy: jsonFileName = "DivineComedy"
            case .danteVitaNuova: jsonFileName = "VitaNuova"
            case .baudelaireFleurs: jsonFileName = "FleursDuMal"
            case .baudelaireSpleen: jsonFileName = "SpleenDeParis"
            case .nerudaVeintePoemas: jsonFileName = "VeintePoemas"
            case .nerudaCantoGeneral: jsonFileName = "CantoGeneral"
            case .garciaLorcaBodas: jsonFileName = "BodasDeSangre"
            case .garciaLorcaYerma: jsonFileName = "Yerma"
            case .valeryCimetiere: jsonFileName = "CimetiereMarin"
            case .valeryCharmes: jsonFileName = "Charmes"
            }
            
            let poetName: String
            let year: Int
            
            switch category {
            case .hafezGhazal, .hafezGhete, .hafezRobaee:
                poetName = "Hafez Shirazi"
                year = 792
            case .saadiGhazal, .saadiBostan:
                poetName = "Saadi Shirazi"
                year = category == .saadiBostan ? 655 : 690
            case .molanaRobaee, .masnavi:
                poetName = "Molana Jalaluddin Balkhi"
                year = 672
            case .babaTaherDoBeyti:
                poetName = "BabaTaher Arian"
                year = 1055
            // New cases for foreign poets
            case .cervantesDonQuixote, .cervantesNovelas:
                poetName = "Miguel de Cervantes"
                year = category == .cervantesDonQuixote ? 1605 : 1613
            case .shakespeareHamlet, .shakespeareMacbeth:
                poetName = "William Shakespeare"
                year = category == .shakespeareHamlet ? 1601 : 1606
            case .keatsOdes, .keatsEndymion:
                poetName = "John Keats"
                year = category == .keatsOdes ? 1819 : 1818
            case .danteDivineComedy, .danteVitaNuova:
                poetName = "Dante Alighieri"
                year = category == .danteDivineComedy ? 1320 : 1295
            case .baudelaireFleurs, .baudelaireSpleen:
                poetName = "Charles Baudelaire"
                year = category == .baudelaireFleurs ? 1857 : 1869
            case .nerudaVeintePoemas, .nerudaCantoGeneral:
                poetName = "Pablo Neruda"
                year = category == .nerudaVeintePoemas ? 1924 : 1950
            case .garciaLorcaBodas, .garciaLorcaYerma:
                poetName = "Federico García Lorca"
                year = category == .garciaLorcaBodas ? 1933 : 1934
            case .valeryCimetiere, .valeryCharmes:
                poetName = "Paul Valéry"
                year = category == .valeryCimetiere ? 1920 : 1922
            }
            
            loadedBooks.append(Book(
                title: category.displayName,
                author: poetName,
                imageName: getBookImage(for: loadedBooks.count),
                description: "مجموعه \(category.displayName)",
                poetType: category.poetType,
                category: category,
                year: year
            ))
        }
        
        books = loadedBooks
    }
    
    func getBooksByPoet(_ poetType: PoetType) -> [Book] {
        return books.filter { $0.poetType == poetType }
    }
    
    func getBooksByCategory(_ category: PoemCategory) -> [Book] {
        return books.filter { $0.category == category }
    }
} 
