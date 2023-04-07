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
    @Published var books = [Book]()
    @Published var showingAlert = false
    @Published var errorMessage = ""
    
    private var lastDocumentSnapshot: QueryDocumentSnapshot?
    private var isFetchingMore = true
    
    func searchBooks(searchText: String) async {
        
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
                    .limit(to: 5)
                    .whereField(FirebaseConstants.titleField, isGreaterThanOrEqualTo: searchText.lowercased())
                    .whereField(FirebaseConstants.titleField, isLessThan: (searchText.lowercased() + "z"))
                    .getDocuments()
                    .documents
            } else {
                documents = try await bookCollection
                    .limit(to: 5)
                    .whereField(FirebaseConstants.titleField, isGreaterThanOrEqualTo: searchText.lowercased())
                    .whereField(FirebaseConstants.titleField, isLessThan: (searchText.lowercased() + "z"))
                    .getDocuments()
                    .documents
            }
            
            books.removeAll()
            
            documents.forEach { snapshot in
                do {
                    let book = try snapshot.data(as: Book.self)
                    books.append(book)
                } catch {
                    showingAlert = true
                    errorMessage = error.localizedDescription
                }
            }
            
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
}
