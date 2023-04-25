//
//  SignUpViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/13/23.
//

import Foundation
import Firebase
import AuthenticationServices

@MainActor
class SignupViewModel: ObservableObject {
    let authMananger = FirebaseAuthManager()
    
    @Published var user: User?
    @Published var errorMessage = ""
    @Published var showingAlert = false
    
    func signupWithEmail(email: String, password: String) async {
        do {
            let result = try await authMananger.createUserWithEmail(email: email, password: password)
            user = result?.user
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func signUpWithGoogle() async {
        do {
            let result = try await authMananger.authenticateWithGoogle()
            user = result?.user
            print("The id is", user?.email ?? "")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func signUpWithFacebook() async {
        do {
            let result = try await authMananger.authenticateWithFacebook()
            user = result?.user
            print("The id is", user?.email ?? "")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func signUpWithApple(currentNonce: String?, result: Result<ASAuthorization, Error>) async {
        do {
            let result = try await authMananger.authenticateWithApple(currentNonce: currentNonce, result: result)
            user = result?.user
            print("The id is", user?.email ?? "")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
}
