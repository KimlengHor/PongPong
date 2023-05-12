//
//  HomeViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/6/23.
//

import Foundation
import Firebase
import UserNotifications

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recentBooks = [Book]()
    @Published var newBooks = [Book]()
    @Published var books = [Book]()
    
    @Published var showingAlert = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var isFetchingMore = true
    
    let authMananger = FirebaseAuthManager()
    
    private let bookManager = BookManager()
    private let userDefaults = UserDefaults.standard
    private let bookIdsKey = UserDefaultConstants.bookIdsKey
    
    func refetchBooks() async {
        isLoading = true
        
        do {
            let (recentBooks, newBooks, allBooks) = try await bookManager.refetchBooks()
            self.recentBooks = recentBooks
            self.newBooks = newBooks
            self.books = allBooks
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func fetchBooks() async {
        
        if isFetchingMore == false {
            return
        }
        
        isLoading = true
        
        do {
            let books = try await bookManager.fetchAllBooks()
            
            if books.isEmpty {
                isFetchingMore = false
            }
            
            self.books.append(contentsOf: books)
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func fetchAllBookTypes() async {
        isLoading = true
        
        do {
            let (recentBooks, newBooks, allBooks) = try await bookManager.fetchAllBookTypes()
            self.recentBooks = recentBooks
            self.newBooks = newBooks
            self.books = allBooks
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signOutUser() {
        do {
            try authMananger.signOutUser()
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async {
        isLoading = true
        
        do {
            try await authMananger.deleteAcount()
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func modifyRecentBooks(book: Book, page: Int) {
        
        guard let contentCount = book.contents?.count else { return }
        let progress = page.calculateProgress(numPages: contentCount)
        
        for i in 0..<recentBooks.count {
            if recentBooks[i].id == book.id {
                recentBooks[i].setProgress(progress)
                return
            }
        }
        
        var book = book
        book.setProgress(progress)
        recentBooks.append(book)
    }
    
    func canRequestReview() -> Bool {
        var storedBookIds =  UserDefaults.standard.array(forKey: bookIdsKey) as? [String] ?? []
        
        if storedBookIds.count >= 5 {
            storedBookIds.removeAll()
            userDefaults.set(storedBookIds, forKey: bookIdsKey)
            return true
        }
        
        return false
    }
    
    func canRequestNotification() -> Bool {
        let storedBookIds =  UserDefaults.standard.array(forKey: bookIdsKey) as? [String] ?? []
        
        if storedBookIds.count >= 2 && storedBookIds.count < 5 {
            return true
        }
        
        return false
    }
}
