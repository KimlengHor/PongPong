//
//  FirebaseAuthManager.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import Foundation
import FirebaseAuth

@MainActor
class FirebaseAuthManager {
    func signInUser(email: String, password: String) async throws -> AuthDataResult? {
        do {
            let authResult = try await FirebaseManager.shared.auth.signIn(withEmail: email, password: password)
            return authResult
        } catch {
            throw error
        }
    }
    
    func forgotPassword(email: String) async throws {
        do {
            try await FirebaseManager.shared.auth.sendPasswordReset(withEmail: email)
        } catch {
            throw error
        }
    }
}
