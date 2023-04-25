//
//  FacebookAuthentication.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/24/23.
//

import Foundation
import FacebookLogin
import FirebaseAuth

@MainActor
final class FacebookAuthentication {
    
    let loginManager = LoginManager()
    
    func loginWithFacebook() async throws -> AuthCredential? {
        return try await withCheckedThrowingContinuation { continuation in
            loginManager.logIn(permissions: ["email"], from: nil) { result, error in
                if let result = result {
                    let credential = FacebookAuthProvider.credential(withAccessToken: result.token?.tokenString ?? "")
                    continuation.resume(returning: credential)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
        }
    }
}
