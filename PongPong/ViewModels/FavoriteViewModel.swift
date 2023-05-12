//
//  FavoriteViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/4/23.
//

import Foundation

@MainActor
class FavoriteViewModel: ObservableObject {
    let bookMananger = BookManager()
    
    @Published var errorMessage = ""
    @Published var showingAlert = false
    @Published var isLoading = false
    
    @Published var books = [Book]()
    
    func fetchFavoriteBooks() async {
        isLoading = true
        
        do {
            books = try await bookMananger.fetchFavoriteBooks()
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func modifyFavBooks(book: Book, remove: Bool = false) {
        if remove {
            for i in 0..<books.count {
                if books[i].id == book.id {
                    books.remove(at: i)
                    return
                }
            }
        } else {
            books.append(book)
        }
    }
}


