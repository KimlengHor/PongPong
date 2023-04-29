//
//  SignInViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import Foundation
import FirebaseAuth
import AuthenticationServices

@MainActor
class SigninViewModel: ObservableObject {
    let authMananger = FirebaseAuthManager()
    
    @Published var user: User?
    @Published var errorMessage = ""
    @Published var showingAlert = false
    @Published var isLoading = false
    
    func signInUser(email: String, password: String) async {
        isLoading = true
        
        do {
            let result = try await authMananger.signInUser(email: email, password: password)
            user = result?.user
            print("The id is", user?.email ?? "")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signInWithGoogle() async {
        isLoading = true
        
        do {
            let result = try await authMananger.authenticateWithGoogle()
            user = result?.user
            print("The id is", user?.email ?? "")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signInWithFacebook() async {
        isLoading = true
        
        do {
            let result = try await authMananger.authenticateWithFacebook()
            user = result?.user
            print("The id is", user?.email ?? "")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signInWithApple(currentNonce: String?, result: Result<ASAuthorization, Error>) async {
        isLoading = true
        
        do {
            let result = try await authMananger.authenticateWithApple(currentNonce: currentNonce, result: result)
            user = result?.user
            print("The id is", user?.email ?? "")
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
