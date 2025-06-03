import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("About Divan")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("""
                    The Divan application has been designed and implemented with the aim of providing easy access to the works of great poets.

                    In this version, you can read and search through the poems of Cervantes, Shakespeare, Keats, Dante, Baudelaire, Neruda, García Lorca, and Valéry. More poets will be added in future versions.

                    Key Features:
                    • Search through poems
                    • Save favorite poems
                    • Share poems
                    • Dark mode support

                    For suggestions and feedback, you can contact us:
                    """)
                .padding(.bottom)
                
                Link("Sothesom@gmail.com", destination: URL(string: "mailto:Sothesom@gmail.com")!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        AboutUsView()
    }
} 
