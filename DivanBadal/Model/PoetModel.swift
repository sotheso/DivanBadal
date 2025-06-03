import SwiftUI

struct Poet: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let bioEnglish: String
    let bioPersian: String
    let works: [String]
    let birthYear: Int
    let deathYear: Int
    let birthPlace: String
    let type: PoetType
    
    func getBio(for language: String) -> String {
        return language == "English" ? bioEnglish : bioPersian
    }
}

extension Poet {
    static let samplePoets: [Poet] = [
        Poet(
            name: "Miguel de Cervantes",
            imageName: "سروانتس",
            bioEnglish: "Spanish novelist, poet, and playwright. Best known for Don Quixote, considered the first modern European novel.",
            bioPersian: "رمان‌نویس، شاعر و نمایشنامه‌نویس اسپانیایی. مشهورترین اثر او دن کیشوت است که اولین رمان مدرن اروپایی محسوب می‌شود.",
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
            bioPersian: "نمایشنامه‌نویس و شاعر انگلیسی، که به عنوان بزرگترین نویسنده زبان انگلیسی شناخته می‌شود.",
            works: ["Hamlet", "Macbeth"],
            birthYear: 1564,
            deathYear: 1616,
            birthPlace: "Stratford-upon-Avon, England",
            type: .shakespeare
        ),
        Poet(
            name: "John Keats",
            imageName: "جان کیتس",
            bioEnglish: "English Romantic poet. His poetry is characterized by sensual imagery and is among the most popular of the Romantic movement.",
            bioPersian: "شاعر رمانتیک انگلیسی. شعر او با تصاویر حسی مشخص می‌شود و از محبوب‌ترین آثار جنبش رمانتیک است.",
            works: ["Odes", "Endymion"],
            birthYear: 1795,
            deathYear: 1821,
            birthPlace: "London, England",
            type: .keats
        ),
        Poet(
            name: "Dante Alighieri",
            imageName: "دانته آلیگیری",
            bioEnglish: "Italian poet, writer, and philosopher. Best known for The Divine Comedy, a masterpiece of world literature.",
            bioPersian: "شاعر، نویسنده و فیلسوف ایتالیایی. مشهورترین اثر او کمدی الهی است که شاهکاری از ادبیات جهان محسوب می‌شود.",
            works: ["The Divine Comedy", "La Vita Nuova"],
            birthYear: 1265,
            deathYear: 1321,
            birthPlace: "Florence, Italy",
            type: .dante
        ),
        Poet(
            name: "Charles Baudelaire",
            imageName: "شارل بودلر",
            bioEnglish: "French poet, translator, and critic. His most famous work, Les Fleurs du mal, expresses the changing nature of beauty in modern, industrializing Paris.",
            bioPersian: "شاعر، مترجم و منتقد فرانسوی. مشهورترین اثر او، گل‌های بدی، بیانگر ماهیت متغیر زیبایی در پاریس مدرن و صنعتی است.",
            works: ["Les Fleurs du mal", "Le Spleen de Paris"],
            birthYear: 1821,
            deathYear: 1867,
            birthPlace: "Paris, France",
            type: .baudelaire
        ),
        Poet(
            name: "Pablo Neruda",
            imageName: "پابلو نروا",
            bioEnglish: "Chilean poet and diplomat. Winner of the Nobel Prize in Literature in 1971. His poetry is known for its passionate love poems and political commitment.",
            bioPersian: "شاعر و دیپلمات شیلیایی. برنده جایزه نوبل ادبیات در سال 1971. شعر او به خاطر اشعار عاشقانه پرشور و تعهد سیاسی شناخته شده است.",
            works: ["Twenty Love Poems", "Canto General"],
            birthYear: 1904,
            deathYear: 1973,
            birthPlace: "Parral, Chile",
            type: .neruda
        ),
        Poet(
            name: "Federico García Lorca",
            imageName: "فدریکو گارسیا",
            bioEnglish: "Spanish poet, playwright, and theatre director. A member of the Generation of '27, he is considered one of the most important Spanish poets of the 20th century.",
            bioPersian: "شاعر، نمایشنامه‌نویس و کارگردان تئاتر اسپانیایی. عضو نسل 27، او یکی از مهمترین شاعران اسپانیایی قرن بیستم محسوب می‌شود.",
            works: ["Blood Wedding", "Yerma"],
            birthYear: 1898,
            deathYear: 1936,
            birthPlace: "Fuente Vaqueros, Spain",
            type: .garcia
        ),
        Poet(
            name: "Paul Valéry",
            imageName: "پل والری",
            bioEnglish: "French poet, essayist, and philosopher. His poetry is characterized by its intellectual depth and formal perfection.",
            bioPersian: "شاعر، مقاله‌نویس و فیلسوف فرانسوی. شعر او با عمق فکری و کمال صوری مشخص می‌شود.",
            works: ["Le Cimetière marin", "Charmes"],
            birthYear: 1871,
            deathYear: 1945,
            birthPlace: "Sète, France",
            type: .valery
        )
    ]
} 
