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
    @Published var showFeedbackView = false
    
    private var bookManager = BookManager()
    
    func addBookToFavorites(book: Book?) async {
        
        guard let bookId = book?.id else {
            errorMessage = "Oops! We're sorry, but at the moment you can't add this book to your favorites list. We're working on fixing this issue and hope to have it resolved soon. Thank you for your patience and understanding!"
            showingAlert = true
            return
        }
        
        isLoading = true
        
        do {
            try await bookManager.addBookToFavorites(bookId: bookId)
            book?.setFavorite(true)
            showFeedbackView = true
            HepticManager.instance.notification(type: .success)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.showFeedbackView = false
            }
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func removeBookFromFavorites(book: Book?) async {
        
        guard let bookId = book?.id else {
            errorMessage = "Oops! We're sorry, but at the moment you can't remove this book to your favorites list. We're working on fixing this issue and hope to have it resolved soon. Thank you for your patience and understanding!"
            showingAlert = true
            return
        }
        
        isLoading = true
        
        do {
            try await bookManager.removeBookFromFavorites(bookId: bookId)
            
            book?.setFavorite(false)
            showFeedbackView = true
            HepticManager.instance.notification(type: .success)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.showFeedbackView = false
            }
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func checkIfBookInFavorites(book: Book?) async {
        guard let bookId = book?.id else {
            book?.setFavorite(false)
            return
        }
        
        do {
            let isFavorite = try await bookManager.checkIfBookInFavorites(bookId: bookId)
            book?.setFavorite(isFavorite)
        } catch {
            book?.setFavorite(false)
        }
    }
}
