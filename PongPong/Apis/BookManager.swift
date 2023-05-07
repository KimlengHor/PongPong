//
//  BookManager.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/4/23.
//

import Foundation
import Firebase

enum CustomError: Error {
    case errorWithMessage(message: String)
}

@MainActor
class BookManager {
    
    private let favCollection = FirebaseManager.shared.firestore
        .collection(FirebaseConstants.favCollection)
    private let email = FirebaseManager.shared.auth.currentUser?.email
    
    func addBookToFavorites(bookId: String) async throws {
        
        guard let email = email else {
            throw CustomError.errorWithMessage(message: "Oops! It looks like you need to have an account with us to add books to your favorites list. Please sign up or log in to your existing account to enjoy this feature.")
        }
        
        let documentRef = favCollection.document(email).collection(FirebaseConstants.bookCollection).document(bookId)
        
        do {
            try await documentRef.setData([:])
        } catch {
            throw error
        }
    }
    
    func removeBookFromFavorites(bookId: String) async throws {
        let documentRef = favCollection.document(email ?? "").collection(FirebaseConstants.bookCollection).document(bookId)
        
        do {
            let document = try await documentRef.getDocument()
            if document.exists {
                try await documentRef.delete()
            }
        } catch {
            throw error
        }
    }
    
    func checkIfBookInFavorites(bookId: String) async throws -> Bool {
        let documentRef = favCollection.document(email ?? "").collection(FirebaseConstants.bookCollection).document(bookId)
        
        do {
            let document = try await documentRef.getDocument()
            if document.exists {
                return true
            } else {
                return false
            }
        } catch {
            throw error
        }
    }
    
    func fetchFavoriteBooks() async throws -> [Book] {
        var books = [Book]()
        
        let collectionRef = favCollection.document(email ?? "").collection(FirebaseConstants.bookCollection)
            
        do {
            let documents = try await collectionRef.getDocuments().documents
            for doc in documents {
                let bookCollectionRef = FirebaseManager.shared.firestore.collection(FirebaseConstants.bookCollection)
                let bookDoc = try await bookCollectionRef.document(doc.documentID).getDocument()
                let book = try bookDoc.data(as: Book.self)
                books.append(book)
            }
            return books
        } catch {
            throw error
        }
    }
}
