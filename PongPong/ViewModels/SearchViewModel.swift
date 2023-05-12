//
//  SearchViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/6/23.
//

import Foundation
import Firebase

@MainActor
class SearchViewModel: ObservableObject {
    @Published var books: [Book]?
    @Published var showingAlert = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var lastDocumentSnapshot: QueryDocumentSnapshot?
    
    private var isFetchingMore = true
    private let limit = 50
    
    func searchBooksAgain(searchText: String) async {
        books?.removeAll()
        await searchBooks(searchText: searchText)
    }
    
    func searchBooks(searchText: String) async {
        
        if books == nil {
            books = [Book]()
        }
        
        isLoading = true
        
        if isFetchingMore == false {
            return
        }
        
        do {
            let bookCollection = FirebaseManager.shared.firestore
                .collection(FirebaseConstants.bookCollection)
            var documents = [QueryDocumentSnapshot]()
            
            if let lastDocumentSnapshot = lastDocumentSnapshot {
                documents = try await bookCollection
                    .start(afterDocument: lastDocumentSnapshot)
                    .limit(to: limit)
                    .whereField(FirebaseConstants.titleField, isGreaterThanOrEqualTo: searchText.lowercased())
                    .whereField(FirebaseConstants.titleField, isLessThan: (searchText.lowercased() + "z"))
                    .getDocuments()
                    .documents
            } else {
                documents = try await bookCollection
                    .limit(to: limit)
                    .whereField(FirebaseConstants.titleField, isGreaterThanOrEqualTo: searchText.lowercased())
                    .whereField(FirebaseConstants.titleField, isLessThan: (searchText.lowercased() + "z"))
                    .getDocuments()
                    .documents
            }
            
            documents.forEach { snapshot in
                do {
                    let book = try snapshot.data(as: Book.self)
                    books?.append(book)
                } catch {
                    showingAlert = true
                    errorMessage = error.localizedDescription
                }
            }
            
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
