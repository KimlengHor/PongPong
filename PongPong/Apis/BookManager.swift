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
    private let recentCollection = FirebaseManager.shared.firestore
        .collection(FirebaseConstants.recentCollection)
    private let bookCollection = FirebaseManager.shared.firestore
        .collection(FirebaseConstants.bookCollection)
    
    private var bookLastDocumentSnapshot: QueryDocumentSnapshot?
    private let limit = 3
    
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
                let bookDoc = try await bookCollection.document(doc.documentID).getDocument()
                let book = try bookDoc.data(as: Book.self)
                books.append(book)
            }
            return books
        } catch {
            throw error
        }
    }
    
    func refetchBooks() async throws -> ([Book], [Book], [Book]) {
        bookLastDocumentSnapshot = nil
        
        do {
            let (recentBooks, newBooks, allBooks) = try await fetchAllBookTypes()
            return (recentBooks, newBooks, allBooks)
        } catch {
            throw error
        }
    }
    
    func fetchAllBooks() async throws -> [Book] {
        var books = [Book]()
        
        do {
            var documents = [QueryDocumentSnapshot]()
            
            if let lastDocumentSnapshot = bookLastDocumentSnapshot {
                documents = try await bookCollection
                    .start(afterDocument: lastDocumentSnapshot)
                    .limit(to: limit)
                    .getDocuments()
                    .documents
            } else {
                documents = try await bookCollection
                    .limit(to: limit)
                    .getDocuments()
                    .documents
            }
            
            bookLastDocumentSnapshot = documents.last
            
            for doc in documents {
                let book = try doc.data(as: Book.self)
                books.append(book)
            }
            return books
        } catch {
            throw error
        }
    }
    
    func fetchNewBooks() async throws -> [Book] {
        var books = [Book]()
        
        do {
            let documents = try await bookCollection
                .order(by: FirebaseConstants.timestampField, descending: true)
                .limit(to: 7)
                .getDocuments()
                .documents
            
            for doc in documents {
                let book = try doc.data(as: Book.self)
                books.append(book)
            }
            return books
        } catch {
            throw error
        }
    }
    
    func fetchAllBookTypes() async throws -> ([Book], [Book], [Book]) {
        async let fetchRecentBooks = fetchRecentBooks()
        async let fetchNewBooks = fetchNewBooks()
        async let fetchAllBooks = fetchAllBooks()
       
        let (recentBooks, newBooks, allBooks) = await (try fetchRecentBooks, try fetchNewBooks, try fetchAllBooks)
        
        return (recentBooks, newBooks, allBooks)
    }
    
    func addBookToRecent(bookId: String, progress: Float) async throws {
        
        let documentRef = recentCollection.document(email ?? "").collection(FirebaseConstants.bookCollection).document(bookId)
        
        do {
            try await documentRef.setData([
                FirebaseConstants.progressField: progress
            ])
        } catch {
            throw error
        }
    }
    
    func fetchRecentBooks() async throws -> [Book] {
        var books = [Book]()
        
        let recentCollectionRef = recentCollection.document(email ?? "").collection(FirebaseConstants.bookCollection)
        
        do {
            let documents = try await recentCollectionRef
                .whereField(FirebaseConstants.progressField, isLessThan: 1)
                .limit(to: 7)
                .getDocuments()
                .documents
            
            for doc in documents {
                if let progress = doc[FirebaseConstants.progressField] as? Float {
                    let bookDoc = try await bookCollection.document(doc.documentID).getDocument()
                    var book = try bookDoc.data(as: Book.self)
                    book.setProgress(String("\(Int(progress * 100))%"))
                    books.append(book)
                }
            }
            return books
        } catch {
            throw error
        }
    }
}
