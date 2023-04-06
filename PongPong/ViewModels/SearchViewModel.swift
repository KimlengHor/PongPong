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
    
    func searchBooks(searchText: String) async {
        do {
            let documents = try await FirebaseManager.shared.firestore
                .collection(FirebaseConstants.bookCollection)
                .whereField(FirebaseConstants.titleField, isGreaterThanOrEqualTo: searchText.lowercased())
                .whereField(FirebaseConstants.titleField, isLessThan: (searchText.lowercased() + "z"))
                .getDocuments()
                .documents
            
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
