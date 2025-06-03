import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "AppLanguage")
        }
    }
    
    private init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? "Turkish"
    }
    
    func localizedString(_ key: LocalizationKey) -> String {
        return key.localizedString(for: currentLanguage)
    }
}

struct LocalizedView: ViewModifier {
    @StateObject private var languageManager = LanguageManager.shared
    
    func body(content: Content) -> some View {
        content
            .environmentObject(languageManager)
    }
}

extension View {
    func localized() -> some View {
        modifier(LocalizedView())
    }
}

enum LocalizationKey {
    // Intro
    case welcome
    case smartLibrary
    case community
    case selectLanguage
    case welcomeSubtitle
    case smartLibrarySubtitle
    case communitySubtitle
    case selectLanguageSubtitle
    case continueButton
    case start
    case skip
    case turkish
    case english
    
    // Home
    case home
    case search
    case library
    case profile
    case newBooks
    case popularBooks
    case recommendedBooks
    case seeAll
    case allBooks
    case noBooksFound
    
    // Search
    case searchPlaceholder
    case searchResults
    case noResults
    case categories
    case filters
    
    // Detail Page
    case bookDetails
    case author
    case publisher
    case publishDate
    case pages
    case description
    case readNow
    case addToLibrary
    case share
    
    // Settings
    case settings
    case language
    case notifications
    case darkMode
    case about 
    case help
    case logout
    
    // New keys
    case back
    case saved
    case save
    case poetryDetails
    case ganjor
    case addedToFavorites
    case removedFromFavorites
    case appearance
    case personalization
    case favoritePoets
    case rateApp
    case developedBy
    case appVersion
    case biography
    
    func localizedString(for language: String) -> String {
        switch language {
        case "Turkish":
            return turkishString
        case "English":
            return englishString
        default:
            return turkishString
        }
    }
    
    private var turkishString: String {
        switch self {
        // Intro
        case .welcome:
            return "Divan'a Hoş Geldiniz"
        case .smartLibrary:
            return "Akıllı Kütüphane"
        case .community:
            return "Okuyucu Topluluğu"
        case .selectLanguage:
            return "Uygulama Dilini Seçin"
        case .welcomeSubtitle:
            return "Divan ile en iyi okuma deneyimini yaşayın"
        case .smartLibrarySubtitle:
            return "Binlerce kitaba tek uygulamadan erişin"
        case .communitySubtitle:
            return "Favori kitaplarınızı arkadaşlarınızla paylaşın"
        case .selectLanguageSubtitle:
            return "Lütfen tercih ettiğiniz dili seçin"
        case .continueButton:
            return "Devam Et"
        case .start:
            return "Başla"
        case .skip:
            return "Atla"
        case .turkish:
            return "Türkçe"
        case .english:
            return "English"
            
        // Home
        case .home:
            return "Ana Sayfa"
        case .search:
            return "Kitaplarda Ara"
        case .library:
            return "Kütüphane"
        case .profile:
            return "Profil"
        case .newBooks:
            return "Yeni Kitaplar"
        case .popularBooks:
            return "Popüler Kitaplar"
        case .recommendedBooks:
            return "Önerilenler"
        case .seeAll:
            return "Tümünü Gör"
        case .allBooks:
            return "Tüm Kitaplar"
        case .noBooksFound:
            return "Kitap Bulunamadı"
            
        // Search
        case .searchPlaceholder:
            return "Kitaplarda ara..."
        case .searchResults:
            return "Arama Sonuçları"
        case .noResults:
            return "Sonuç Bulunamadı"
        case .categories:
            return "Kategoriler"
        case .filters:
            return "Filtreler"
            
        // Detail Page
        case .bookDetails:
            return "Kitap Detayları"
        case .author:
            return "Yazar"
        case .publisher:
            return "Yayınevi"
        case .publishDate:
            return "Yayın Tarihi"
        case .pages:
            return "Sayfa Sayısı"
        case .description:
            return "Açıklama"
        case .readNow:
            return "Oku"
        case .addToLibrary:
            return "Kütüphaneye Ekle"
        case .share:
            return "Paylaş"
            
        // Settings
        case .settings:
            return "Ayarlar"
        case .language:
            return "Dil"
        case .notifications:
            return "Bildirimler"
        case .darkMode:
            return "Karanlık Mod"
        case .about:
            return "Hakkımızda"
        case .help:
            return "Yardım"
        case .logout:
            return "Çıkış"
            
        // New keys
        case .back:
            return "Geri"
        case .saved:
            return "Kaydedildi"
        case .save:
            return "Kaydet"
        case .poetryDetails:
            return "Şiir Detayları"
        case .ganjor:
            return "Ganjor"
        case .addedToFavorites:
            return "Favorilere Eklendi"
        case .removedFromFavorites:
            return "Favorilerden Çıkarıldı"
        case .appearance:
            return "Görünüm"
        case .personalization:
            return "Kişiselleştirme"
        case .favoritePoets:
            return "Favori Şairler"
        case .rateApp:
            return "Uygulamayı Değerlendir"
        case .developedBy:
            return "Geliştirici"
        case .appVersion:
            return "Uygulama Versiyonu"
        case .biography:
            return "Biyografi"
        }
    }
    
    private var englishString: String {
        switch self {
        // Intro
        case .welcome:
            return "Welcome to Divan"
        case .smartLibrary:
            return "Smart Library"
        case .community:
            return "Reader Community"
        case .selectLanguage:
            return "Select App Language"
        case .welcomeSubtitle:
            return "Experience the best reading journey with Divan"
        case .smartLibrarySubtitle:
            return "Access thousands of books in one app"
        case .communitySubtitle:
            return "Share your favorite books with friends"
        case .selectLanguageSubtitle:
            return "Please select your preferred language"
        case .continueButton:
            return "Continue"
        case .start:
            return "Start"
        case .skip:
            return "Skip"
        case .turkish:
            return "Türkçe"
        case .english:
            return "English"
            
        // Home
        case .home:
            return "Home"
        case .search:
            return "Search in Books"
        case .library:
            return "Library"
        case .profile:
            return "Profile"
        case .newBooks:
            return "New Books"
        case .popularBooks:
            return "Popular Books"
        case .recommendedBooks:
            return "Recommended"
        case .seeAll:
            return "See All"
        case .allBooks:
            return "All Books"
        case .noBooksFound:
            return "No Books Found"
            
        // Search
        case .searchPlaceholder:
            return "Search in books..."
        case .searchResults:
            return "Search Results"
        case .noResults:
            return "No Results Found"
        case .categories:
            return "Categories"
        case .filters:
            return "Filters"
            
        // Detail Page
        case .bookDetails:
            return "Book Details"
        case .author:
            return "Author"
        case .publisher:
            return "Publisher"
        case .publishDate:
            return "Publish Date"
        case .pages:
            return "Pages"
        case .description:
            return "Description"
        case .readNow:
            return "Read Now"
        case .addToLibrary:
            return "Add to Library"
        case .share:
            return "Share"
            
        // Settings
        case .settings:
            return "Settings"
        case .language:
            return "Language"
        case .notifications:
            return "Notifications"
        case .darkMode:
            return "Dark Mode"
        case .about:
            return "About"
        case .help:
            return "Help"
        case .logout:
            return "Logout"
            
        // New keys
        case .back:
            return "Back"
        case .saved:
            return "Saved"
        case .save:
            return "Save"
        case .poetryDetails:
            return "Poetry Details"
        case .ganjor:
            return "Ganjoor"
        case .addedToFavorites:
            return "Added to Favorites"
        case .removedFromFavorites:
            return "Removed from Favorites"
        case .appearance:
            return "App Appearance"
        case .personalization:
            return "Personalization"
        case .favoritePoets:
            return "Favorite Poets"
        case .rateApp:
            return "Rate App"
        case .developedBy:
            return "Developed By"
        case .appVersion:
            return "App Version"
        case .biography:
            return "Biography"
        }
    }
} 
