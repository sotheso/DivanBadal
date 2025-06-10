import SwiftUI

struct Poet: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let bioEnglish: String
    let bioTurkish: String
    let works: [String]
    let birthYear: Int
    let deathYear: Int
    let birthPlace: String
    let type: PoetType
    
    func getBio(for language: String) -> String {
        return language == "English" ? bioEnglish : bioTurkish
    }
}

extension Poet {
    static let samplePoets: [Poet] = [
        Poet(
            name: "Miguel de Cervantes",
            imageName: "Cervantes",
            bioEnglish: "Spanish novelist, poet, and playwright. Best known for Don Quixote, considered the first modern European novel.",
            bioTurkish: "İspanyol romancı, şair ve oyun yazarı. En çok, ilk modern Avrupa romanı olarak kabul edilen Don Kişot ile tanınır.",
            works: ["Don Quixote", "Exemplary Novels"],
            birthYear: 1547,
            deathYear: 1616,
            birthPlace: "Alcalá de Henares, Spain",
            type: .cervantes
        ),
        Poet(
            name: "William Shakespeare",
            imageName: "Sheks",
            bioEnglish: "English playwright and poet, widely regarded as the greatest writer in the English language.",
            bioTurkish: "İngiliz oyun yazarı ve şair, İngiliz dilinin en büyük yazarı olarak kabul edilir.",
            works: ["Hamlet", "Macbeth"],
            birthYear: 1564,
            deathYear: 1616,
            birthPlace: "Stratford-upon-Avon, England",
            type: .shakespeare
        ),
        Poet(
            name: "John Keats",
            imageName: "John",
            bioEnglish: "English Romantic poet. His poetry is characterized by sensual imagery and is among the most popular of the Romantic movement.",
            bioTurkish: "İngiliz Romantik şair. Şiirleri duyusal imgelerle karakterize edilir ve Romantik hareketin en popüler eserleri arasındadır.",
            works: ["Odes", "Endymion"],
            birthYear: 1795,
            deathYear: 1821,
            birthPlace: "London, England",
            type: .keats
        ),
        Poet(
            name: "Dante Alighieri",
            imageName: "Dante",
            bioEnglish: "Italian poet, writer, and philosopher. Best known for The Divine Comedy, a masterpiece of world literature.",
            bioTurkish: "İtalyan şair, yazar ve filozof. Dünya edebiyatının başyapıtlarından biri olan İlahi Komedya ile tanınır.",
            works: ["The Divine Comedy", "La Vita Nuova"],
            birthYear: 1265,
            deathYear: 1321,
            birthPlace: "Florence, Italy",
            type: .dante
        ),
        Poet(
            name: "Charles Baudelaire",
            imageName: "Charles",
            bioEnglish: "French poet, translator, and critic. His most famous work, Les Fleurs du mal, expresses the changing nature of beauty in modern, industrializing Paris.",
            bioTurkish: "Fransız şair, çevirmen ve eleştirmen. En ünlü eseri Kötülük Çiçekleri, modern, sanayileşen Paris'te güzelliğin değişen doğasını ifade eder.",
            works: ["Les Fleurs du mal", "Le Spleen de Paris"],
            birthYear: 1821,
            deathYear: 1867,
            birthPlace: "Paris, France",
            type: .baudelaire
        ),
        Poet(
            name: "Pablo Neruda",
            imageName: "Pablo",
            bioEnglish: "Chilean poet and diplomat. Winner of the Nobel Prize in Literature in 1971. His poetry is known for its passionate love poems and political commitment.",
            bioTurkish: "Şilili şair ve diplomat. 1971'de Nobel Edebiyat Ödülü'nü kazandı. Şiirleri tutkulu aşk şiirleri ve politik bağlılığı ile tanınır.",
            works: ["Twenty Love Poems", "Canto General"],
            birthYear: 1904,
            deathYear: 1973,
            birthPlace: "Parral, Chile",
            type: .neruda
        ),
        Poet(
            name: "Federico García Lorca",
            imageName: "Federico",
            bioEnglish: "Spanish poet, playwright, and theatre director. A member of the Generation of '27, he is considered one of the most important Spanish poets of the 20th century.",
            bioTurkish: "İspanyol şair, oyun yazarı ve tiyatro yönetmeni. 27 Kuşağı'nın bir üyesi olarak, 20. yüzyılın en önemli İspanyol şairlerinden biri olarak kabul edilir.",
            works: ["Blood Wedding", "Yerma"],
            birthYear: 1898,
            deathYear: 1936,
            birthPlace: "Fuente Vaqueros, Spain",
            type: .garcia
        ),
        Poet(
            name: "Paul Valéry",
            imageName: "Paul",
            bioEnglish: "French poet, essayist, and philosopher. His poetry is characterized by its intellectual depth and formal perfection.",
            bioTurkish: "Fransız şair, deneme yazarı ve filozof. Şiirleri entelektüel derinliği ve biçimsel mükemmelliği ile karakterize edilir.",
            works: ["Le Cimetière marin", "Charmes"],
            birthYear: 1871,
            deathYear: 1945,
            birthPlace: "Sète, France",
            type: .valery
        )
    ]
} 
