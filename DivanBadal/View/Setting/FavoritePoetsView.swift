import SwiftUI

struct FavoritePoetsView: View {
    @StateObject private var favoritesManager = FavoritePoetsManager()
    @EnvironmentObject private var languageManager: LanguageManager
    let poets: [Poet]
    
    var favoritePoets: [Poet] {
        poets.filter { favoritesManager.isFavorite($0.id.uuidString) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if favoritePoets.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "star.slash.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary)
                    
                    Text(languageManager.localizedString(.noPoetSelected))
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGroupedBackground))
            } else {
                List {
                    ForEach(favoritePoets) { poet in
                        NavigationLink(destination: PoetProfileView(poet: poet)) {
                            HStack {
                                VStack(alignment: .trailing) {
                                    Text(poet.name)
                                        .font(.headline)
                                    Text("\(poet.birthYear) - \(poet.deathYear)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(poet.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(languageManager.localizedString(.favoritePoets))
        .localized()
    }
}

#Preview {
    NavigationStack {
        FavoritePoetsView(poets: Poet.samplePoets)
            .environmentObject(LanguageManager.shared)
    }
} 
