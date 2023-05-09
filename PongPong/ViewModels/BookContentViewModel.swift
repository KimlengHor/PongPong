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
    @Published var feedbackText = ""
    @Published var feedbackImageName = ""
    
    @Published var isBookFavorite = false
    @Published var favButtonImageName = ""
    @Published var favButtonText = ""
    
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
            setupFeedbackView(text: "Added to favorites", imageName: "star.fill", isFavorite: true)
            setupFavButton(text: "Removed from favorites", imageName: "star.slash.fill")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func removeBookFromFavorites(bookId: String?) async {
        
        guard let bookId = bookId else {
            errorMessage = "Oops! We're sorry, but at the moment you can't remove this book to your favorites list. We're working on fixing this issue and hope to have it resolved soon. Thank you for your patience and understanding!"
            showingAlert = true
            return
        }
        
        isLoading = true
        
        do {
            try await bookManager.removeBookFromFavorites(bookId: bookId)
            setupFeedbackView(text: "Removed to favorites", imageName: "star.slash.fill", isFavorite: false)
            setupFavButton(text: "Add to favorites", imageName: "star.fill")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func checkIfBookInFavorites(book: Book?) async {
        setupFavButton(text: "Add to favorites", imageName: "star.fill")
        guard let bookId = book?.id else {
            isBookFavorite = false
            return
        }
        
        do {
            let isFavorite = try await bookManager.checkIfBookInFavorites(bookId: bookId)
            if isFavorite == true {
                isBookFavorite = true
                setupFavButton(text: "Remove from favorites", imageName: "star.slash.fill")
            }
            
        } catch {
            isBookFavorite = false
        }
    }
    
    func addBookToRecent(book: Book?, page: Int) async {
        
        guard let bookId = book?.id, let numPages = book?.contents?.count else {
            return
        }
        
        let progress = calculateProgress(page: page, numPages: numPages)
        
        do {
            try await bookManager.addBookToRecent(bookId: bookId, progress: progress)
        } catch {}
        
    }
    
    func calculateProgress(page: Int, numPages: Int) -> Float {
        let progress = Float(page + 1) / Float(numPages)
        return progress
    }
    
    func setupFeedbackView(text: String, imageName: String, isFavorite: Bool) {
        isBookFavorite = isFavorite
        showFeedbackView = true
        feedbackText = text
        feedbackImageName = imageName
        
        HepticManager.instance.notification(type: .success)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.showFeedbackView = false
        }
    }
    
    func setupFavButton(text: String, imageName: String) {
        favButtonText = text
        favButtonImageName = imageName
    }
}
