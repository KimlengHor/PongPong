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
    
    func fetchBooks() async {
        do {
            let documents = try await FirebaseManager.shared.firestore
                .collection(FirebaseConstants.bookCollection)
                .getDocuments()
                .documents
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

    func searchBooks(searchText: String) async {
        do {
            let documents = try await FirebaseManager.shared.firestore
                .collection(FirebaseConstants.bookCollection)
                .whereField(FirebaseConstants.titleField, isGreaterThanOrEqualTo: searchText.lowercased())
                .whereField(FirebaseConstants.titleField, isLessThan: (searchText.lowercased() + "z"))
                .getDocuments()
                .documents
            
            print(documents)
            
            documents.forEach { snapshot in
                do {
                    let book = try snapshot.data(as: Book.self)
//                    books.append(book)
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
