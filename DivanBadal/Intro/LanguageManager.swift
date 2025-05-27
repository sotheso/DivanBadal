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
        self.currentLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? "English"
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
    case persian
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
    
    func localizedString(for language: String) -> String {
        switch language {
        case "فارسی":
            return persianString
        case "English":
            return englishString
        default:
            return persianString
        }
    }
    
    private var persianString: String {
        switch self {
        // Intro
        case .welcome:
            return "به دیوان خوش آمدید"
        case .smartLibrary:
            return "کتابخانه هوشمند"
        case .community:
            return "جامعه کتابخوان"
        case .selectLanguage:
            return "زبان برنامه را انتخاب کنید"
        case .welcomeSubtitle:
            return "بهترین تجربه کتابخوانی را با دیوان تجربه کنید"
        case .smartLibrarySubtitle:
            return "دسترسی به هزاران کتاب در یک اپلیکیشن"
        case .communitySubtitle:
            return "با دوستان خود کتاب‌های مورد علاقه را به اشتراک بگذارید"
        case .selectLanguageSubtitle:
            return "لطفاً زبان مورد نظر خود را انتخاب کنید"
        case .continueButton:
            return "ادامه"
        case .start:
            return "شروع کنید"
        case .skip:
            return "رد کردن"
        case .persian:
            return "فارسی"
        case .english:
            return "English"
            
        // Home
        case .home:
            return "خانه"
        case .search:
            return "جستجو در کتاب‌ها"
        case .library:
            return "کتابخانه"
        case .profile:
            return "پروفایل"
        case .newBooks:
            return "کتاب‌های جدید"
        case .popularBooks:
            return "کتاب‌های پرفروش"
        case .recommendedBooks:
            return "پیشنهاد شده‌ها"
        case .seeAll:
            return "مشاهده همه"
        case .allBooks:
            return "همه کتاب‌ها"
        case .noBooksFound:
            return "کتابی یافت نشد"
            
        // Search
        case .searchPlaceholder:
            return "جستجو در کتاب‌ها..."
        case .searchResults:
            return "نتایج جستجو"
        case .noResults:
            return "نتیجه‌ای یافت نشد"
        case .categories:
            return "دسته‌بندی‌ها"
        case .filters:
            return "فیلترها"
            
        // Detail Page
        case .bookDetails:
            return "جزئیات کتاب"
        case .author:
            return "نویسنده"
        case .publisher:
            return "ناشر"
        case .publishDate:
            return "تاریخ انتشار"
        case .pages:
            return "تعداد صفحات"
        case .description:
            return "توضیحات"
        case .readNow:
            return "خواندن"
        case .addToLibrary:
            return "افزودن به کتابخانه"
        case .share:
            return "اشتراک‌گذاری"
            
        // Settings
        case .settings:
            return "تنظیمات"
        case .language:
            return "زبان"
        case .notifications:
            return "اعلان‌ها"
        case .darkMode:
            return "حالت تاریک"
        case .about:
            return "درباره ما"
        case .help:
            return "راهنما"
        case .logout:
            return "خروج"
            
        // New keys
        case .back:
            return "بازگشت"
        case .saved:
            return "ذخیره شده"
        case .save:
            return "ذخیره"
        case .poetryDetails:
            return "جزئیات شعر"
        case .ganjor:
            return "گنجور"
        case .addedToFavorites:
            return "به علاقه‌مندی‌ها اضافه شد"
        case .removedFromFavorites:
            return "از علاقه‌مندی‌ها حذف شد"
        case .appearance:
            return "ظاهر برنامه"
        case .personalization:
            return "شخصی‌سازی"
        case .favoritePoets:
            return "شاعران مورد علاقه"
        case .rateApp:
            return "امتیاز به برنامه"
        case .developedBy:
            return "توسعه‌دهنده: "
        case .appVersion:
            return "نسخه برنامه"
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
        case .persian:
            return "فارسی"
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
            return "Ganjor"
        case .addedToFavorites:
            return "Added to favorites"
        case .removedFromFavorites:
            return "Removed from favorites"
        case .appearance:
            return "App Appearance"
        case .personalization:
            return "Personalization"
        case .favoritePoets:
            return "Favorite Poets"
        case .rateApp:
            return "Rate App"
        case .developedBy:
            return "Developed by "
        case .appVersion:
            return "App Version"
        }
    }
} 