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
    @Published var books = [Book]()
    @Published var showingAlert = false
    @Published var errorMessage = ""
     
    private var lastDocumentSnapshot: QueryDocumentSnapshot?
    private var isFetchingMore = true
    
    func refetchBooks() async {
        books.removeAll()
        lastDocumentSnapshot = nil
        
        await fetchBooks()
    }
    
    func fetchBooks() async {
        
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
                    .getDocuments()
                    .documents
            } else {
                documents = try await bookCollection
                    .limit(to: 5)
                    .getDocuments()
                    .documents
            }
            
            if documents.isEmpty {
                isFetchingMore = false
            }
            
            documents.forEach { snapshot in
                do {
                    let book = try snapshot.data(as: Book.self)
                    books.append(book)
                } catch {
                    showingAlert = true
                    errorMessage = error.localizedDescription
                }
            }
            
            //keep track the last document for pagination
            lastDocumentSnapshot = documents.last
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
}
