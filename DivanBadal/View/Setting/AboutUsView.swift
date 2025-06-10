import SwiftUI

struct AboutUsView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(languageManager.localizedString(.aboutDivan))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text(languageManager.localizedString(.aboutDivanDescription))
                .padding(.bottom)
                
                Link(languageManager.localizedString(.contactEmail), destination: URL(string: "mailto:Sothesom@gmail.com")!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .localized()
    }
}

#Preview {
    NavigationView {
        AboutUsView()
            .environmentObject(LanguageManager.shared)
    }
} 
