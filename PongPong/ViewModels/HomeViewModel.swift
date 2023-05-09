//
//  HomeViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/6/23.
//

import Foundation
import Firebase

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recentBooks = [Book]()
    @Published var newBooks = [Book]()
    @Published var books = [Book]()
    
    @Published var showingAlert = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var isFetchingMore = true
    
    private let bookManager = BookManager()
    
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
}
