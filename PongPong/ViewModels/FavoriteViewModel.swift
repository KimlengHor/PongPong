//
//  FavoriteViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/4/23.
//

import Foundation
import Firebase

@MainActor
class FavoriteViewModel: ObservableObject {
    let authMananger = FirebaseAuthManager()
    let bookMananger = BookManager()
    
    @Published var errorMessage = ""
    @Published var showingAlert = false
    @Published var isLoading = false
    
    @Published var books = [Book]()
    
    func signOutUser() {
        do {
            try authMananger.signOutUser()
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async {
        isLoading = true
        
        do {
            try await authMananger.deleteAcount()
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
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
}


