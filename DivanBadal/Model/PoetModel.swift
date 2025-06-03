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
    
    static let samplePoets: [Poet] = [
        Poet(
            name: "Hafez",
            imageName: "Hafez",
            bioEnglish: "Khajeh Shams al-Din Muhammad ibn Baha al-Din Muhammad Hafez Shirazi, known as Lisan al-Ghayb, Tarjuman al-Asrar, Lisan al-Arefa, and Nazim al-Awliya, was a great poet of the 8th century Iran and one of the renowned orators worldwide.",
            bioPersian: "خواجه شمس‌الدین محمد بن بهاءالدین محمد حافظ شیرازی، معروف به لسان‌الغیب، ترجمان الاسرار، لسان‌العرفا و ناظم‌الاولیا، شاعر بزرگ سدهٔ هشتم ایران و یکی از سخنوران نامی جهان است.",
            works: ["غزلیات", "قصاید", "مثنویات", "رباعیات"],
            birthYear: 726,
            deathYear: 792,
            birthPlace: "Shiraz",
            type: .hafez
        ),
        Poet(
            name: "Saadi",
            imageName: "Saadi",
            bioEnglish: "Abu Muhammad Mosleh ibn Abdullah, known as Saadi Shirazi and Mosharraf al-Din, was a Persian-speaking Iranian poet and writer. Literary figures have given him titles such as Master of Speech, King of Speech, and Sheikh al-Ajal.",
            bioPersian: "ابومحمد مُصلِح بن عَبدُالله مشهور به سعدی شیرازی و مشرف‌الدین، شاعر و نویسندهٔ پارسی‌گوی ایرانی است. اهل ادب به او لقب استادِ سخن، پادشاهِ سخن، شیخِ اجلّ و حتی به طور مطلق، استاد داده‌اند.",
            works: ["بوستان", "گلستان", "غزلیات", "قصاید"],
            birthYear: 606,
            deathYear: 690,
            birthPlace: "Shiraz",
            type: .saadi
        ),
        Poet(
            name: "BabaTaher",
            imageName: "BabaTaher",
            bioEnglish: "Babataher Arian Hamadani, known as Babataher Arian, was a mystic, poet, and do-bayti (two-couplet) composer from late 4th and mid-5th century AH Iran. He was a contemporary of Tughril Beg of the Seljuk dynasty.",
            bioPersian: "باباطاهر عریان همدانی معروف به باباطاهر عریان، عارف، شاعر و دوبیتی‌سرای اواخر سدهٔ چهارم و اواسط سدهٔ پنجم هجری ایران و معاصر طغرل بیک سلجوقی بوده‌است.",
            works: ["دوبیتی‌ها", "کلمات قصار"],
            birthYear: 1000,
            deathYear: 1055,
            birthPlace: "Hamedan",
            type: .babaTaher
        ),
        Poet(
            name: "Molana",
            imageName: "Molana",
            bioEnglish: "Jalaluddin Muhammad Balkhi, known as Molavi, Molana, and Rumi, was a great poet of the 7th century AH. He is one of the most famous Persian-speaking Iranian poets. Molavi is renowned for his significant contribution to Persian literature and poetry.",
            bioPersian: "جلال‌الدین محمد بلخی معروف به مولوی، مولانا و رومی، شاعر بزرگ قرن هفتم هجری قمری است. ایشان از مشهورترین شاعران ایرانی پارسی‌گوی است. مولوی از مشهورترین شاعران ایرانی و پارسی‌گوی است.",
            works: ["مثنوی معنوی", "دیوان شمس", "فیه ما فیه", "مجالس سبعه"],
            birthYear: 604,
            deathYear: 672,
            birthPlace: "Balkh",
            type: .molana
        ),
        Poet(
            name: "Cervantes",
            imageName: "سروانتس",
            bioEnglish: "Miguel de Cervantes Saavedra was a Spanish writer widely regarded as the greatest writer in the Spanish language and one of the world's pre-eminent novelists. He is best known for his novel Don Quixote.",
            bioPersian: "میگل د سروانتس ساودرا نویسنده اسپانیایی است که به عنوان بزرگترین نویسنده زبان اسپانیایی و یکی از برجسته‌ترین رمان‌نویسان جهان شناخته می‌شود. او بیشتر به خاطر رمان دن کیشوت شناخته شده است.",
            works: ["دن کیشوت", "نوولاهای نمونه", "سفر به پارناسوس"],
            birthYear: 1547,
            deathYear: 1616,
            birthPlace: "Alcalá de Henares",
            type: .cervantes
        ),
        Poet(
            name: "Shakespeare",
            imageName: "Sheks",
            bioEnglish: "William Shakespeare was an English playwright, poet and actor. He is widely regarded as the greatest writer in the English language and the world's pre-eminent dramatist.",
            bioPersian: "ویلیام شکسپیر نمایشنامه‌نویس، شاعر و بازیگر انگلیسی بود. او به عنوان بزرگترین نویسنده زبان انگلیسی و برجسته‌ترین نمایشنامه‌نویس جهان شناخته می‌شود.",
            works: ["هملت", "مکبث", "اتللو", "شاه لیر"],
            birthYear: 1564,
            deathYear: 1616,
            birthPlace: "Stratford-upon-Avon",
            type: .shakespeare
        ),
        Poet(
            name: "Keats",
            imageName: "جان کیتس",
            bioEnglish: "John Keats was an English Romantic poet. He was one of the main figures of the second generation of Romantic poets, along with Lord Byron and Percy Bysshe Shelley.",
            bioPersian: "جان کیتس شاعر رمانتیک انگلیسی بود. او یکی از چهره‌های اصلی نسل دوم شاعران رمانتیک، همراه با لرد بایرون و پرسی بیش شلی بود.",
            works: ["Endymion", "Ode to a Nightingale", "Ode on a Grecian Urn"],
            birthYear: 1795,
            deathYear: 1821,
            birthPlace: "London",
            type: .keats
        ),
        Poet(
            name: "Dante",
            imageName: "دانته آلیگیری",
            bioEnglish: "Dante Alighieri was an Italian poet, writer and philosopher. His Divine Comedy is widely considered one of the most important poems of the Middle Ages and the greatest literary work in the Italian language.",
            bioPersian: "دانته آلیگیری شاعر، نویسنده و فیلسوف ایتالیایی بود. کمدی الهی او به طور گسترده‌ای یکی از مهمترین شعرهای قرون وسطی و بزرگترین اثر ادبی به زبان ایتالیایی محسوب می‌شود.",
            works: ["کمدی الهی", "زندگی نو", "ضیافت"],
            birthYear: 1265,
            deathYear: 1321,
            birthPlace: "Florence",
            type: .dante
        ),
        Poet(
            name: "Baudelaire",
            imageName: "شارل بودلر",
            bioEnglish: "Charles Baudelaire was a French poet who also produced notable work as an essayist, art critic, and translator. His most famous work, Les Fleurs du mal, expresses the changing nature of beauty in modern, industrializing Paris.",
            bioPersian: "شارل بودلر شاعر فرانسوی بود که همچنین به عنوان مقاله‌نویس، منتقد هنری و مترجم آثار قابل توجهی خلق کرد. معروفترین اثر او، گل‌های بدی، بیانگر ماهیت متغیر زیبایی در پاریس مدرن و صنعتی است.",
            works: ["گل‌های بدی", "اسپلن پاریس", "نقدهای هنری"],
            birthYear: 1821,
            deathYear: 1867,
            birthPlace: "Paris",
            type: .baudelaire
        ),
        Poet(
            name: "Neruda",
            imageName: "پابلو نروا",
            bioEnglish: "Pablo Neruda was a Chilean poet-diplomat and politician who won the Nobel Prize for Literature in 1971. Neruda became known as a poet when he was 13 years old, and wrote in a variety of styles.",
            bioPersian: "پابلو نرودا شاعر-دیپلمات و سیاستمدار شیلیایی بود که در سال 1971 برنده جایزه نوبل ادبیات شد. نرودا در 13 سالگی به عنوان شاعر شناخته شد و در سبک‌های مختلف شعر می‌سرود.",
            works: ["بیست شعر عاشقانه و یک ترانه نومیدی", "اقامت در زمین", "کاپیتان ورد"],
            birthYear: 1904,
            deathYear: 1973,
            birthPlace: "Parral",
            type: .neruda
        ),
        Poet(
            name: "Garcia",
            imageName: "فدریکو گارسیا",
            bioEnglish: "Federico García Lorca was a Spanish poet, playwright, and theatre director. He achieved international recognition as an emblematic member of the Generation of '27.",
            bioPersian: "فدریکو گارسیا لورکا شاعر، نمایشنامه‌نویس و کارگردان تئاتر اسپانیایی بود. او به عنوان عضو نمادین نسل 27 به شهرت بین‌المللی دست یافت.",
            works: ["خانه برناردا آلبا", "یرما", "عروسی خون"],
            birthYear: 1898,
            deathYear: 1936,
            birthPlace: "Fuente Vaqueros",
            type: .garcia
        ),
        Poet(
            name: "Valery",
            imageName: "پل والری",
            bioEnglish: "Paul Valéry was a French poet, essayist, and philosopher. In addition to his poetry and fiction, his interests included aphorisms on art, history, letters, music, and current events.",
            bioPersian: "پل والری شاعر، مقاله‌نویس و فیلسوف فرانسوی بود. علاوه بر شعر و داستان، علایق او شامل حکایات درباره هنر، تاریخ، نامه‌ها، موسیقی و رویدادهای جاری بود.",
            works: ["قبرستان دریایی", "آقای تست", "دفترچه‌ها"],
            birthYear: 1871,
            deathYear: 1945,
            birthPlace: "Sète",
            type: .valery
        )
    ]
} 
