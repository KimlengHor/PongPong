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
    func addBookToFavorites(bookId: String) async throws {
        
        let favCollection = FirebaseManager.shared.firestore
            .collection(FirebaseConstants.favCollection)
        
        guard let email = FirebaseManager.shared.auth.currentUser?.email else {
            throw CustomError.errorWithMessage(message: "Oops! It looks like you need to have an account with us to add books to your favorites list. Please sign up or log in to your existing account to enjoy this feature.")
        }
        
        let documentRef = favCollection.document(email).collection(FirebaseConstants.bookCollection).document(bookId)
        
        do {
            try await documentRef.setData([:])
        } catch {
            throw error
        }
    }
}
