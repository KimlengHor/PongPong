//
//  SignInViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import Foundation
import FirebaseAuth

@MainActor
class SigninViewModel: ObservableObject {
    let authMananger = FirebaseAuthManager()
    
    @Published var user: User?
    @Published var errorMessage = ""
    @Published var showingAlert = false
    
    func signInUser(email: String, password: String) async {
        do {
            let result = try await authMananger.signInUser(email: email, password: password)
            user = result?.user
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
}
