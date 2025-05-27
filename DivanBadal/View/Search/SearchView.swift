//
//  SearchView.swift
//  DivanBadal
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI

// کامپوننت جدید برای نمایش کارت کتاب در صفحه جستجو
struct SearchBookCardView: View {
    let book: Book
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var languageManager: LanguageManager
    
    var body: some View {
        ZStack(alignment: .center) {
            // Book Image with fallback
            if let uiImage = UIImage(named: book.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Image("‌Book1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Text
            VStack(spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(1)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .frame(width: 160, height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(
            color: Color("AccentColor").opacity(0.3),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

struct SearchView: View {
    @StateObject private var bookModel = BookModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var languageManager: LanguageManager
    var selectedCategory: PoemCategory?
    @State private var searchText = ""
    
    init(selectedCategory: PoemCategory? = nil) {
        self.selectedCategory = selectedCategory
    }
    
    // تابع کمکی برای پیدا کردن شاعر مربوط به هر کتاب
    private func getPoetForBook(_ book: Book) -> Poet? {
        return Poet.samplePoets.first { $0.type == book.poetType }
    }
    
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return selectedCategory != nil ? 
                bookModel.books.filter { $0.category == selectedCategory } :
                bookModel.books
        } else {
            let books = selectedCategory != nil ?
                bookModel.books.filter { $0.category == selectedCategory } :
                bookModel.books
            
            return books.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            // بکگراند اصلی
            Color("Color Back")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // نوار جستجو
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color("Color"))
                    
                    TextField(languageManager.localizedString(.searchPlaceholder), text: $searchText)
                        .textFieldStyle(.plain)
                        .submitLabel(.search)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                }
                .padding()
                .background(Color("Color Back"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("Color").opacity(0.2), lineWidth: 1)
                )
                .shadow(color: Color("AccentColor").opacity(0.3), radius: 4, x: 0, y: 2)
                .padding()
                
                if filteredBooks.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(filteredBooks) { book in
                                if let poet = getPoetForBook(book) {
                                    NavigationLink(destination: PoetProfileView(poet: poet)) {
                                        SearchBookCardView(book: book)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(selectedCategory?.displayName ?? languageManager.localizedString(.search))
                    .font(.headline)
                    .foregroundStyle(Color("Color"))
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text(languageManager.localizedString(.back))
                    }
                }
            }
        }
        .localized()
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed.fill")
                .font(.system(size: 48))
                .foregroundStyle(Color("Color"))
            
            Text(languageManager.localizedString(.noResults))
                .font(.headline)
                .foregroundStyle(Color("Color"))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Color Back"))
    }
}

#Preview {
    NavigationStack {
        SearchView()
            .environmentObject(LanguageManager.shared)
    }
} 