//
//  BookContentViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/4/23.
//

import Foundation

@MainActor
class BookContentViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var showingAlert = false
    
    private var bookManager = BookManager()
    
    func addBookToFavorites(bookId: String?) async {
        
        guard let bookId = bookId else {
            errorMessage = "Oops! We're sorry, but at the moment you can't add this book to your favorites list. We're working on fixing this issue and hope to have it resolved soon. Thank you for your patience and understanding!"
            showingAlert = true
            return
        }
        
        isLoading = true
        
        do {
            try await bookManager.addBookToFavorites(bookId: bookId)
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
