//
//  FirebaseAuthManager.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FacebookLogin
import AuthenticationServices

@MainActor
class FirebaseAuthManager {
    
    func createUserWithEmail(email: String, password: String) async throws -> AuthDataResult? {
        do {
            let authResult = try await FirebaseManager.shared.auth.createUser(withEmail: email, password: password)
            return authResult
        } catch {
            throw error
        }
    }
    
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
    
    func authenticateWithGoogle() async throws -> AuthDataResult? {
        do {
            guard let clientID = FirebaseManager.shared.app?.options.clientID else { return nil }
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return nil }
            
            let configuration = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = configuration
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            let user = result.user
            guard let idToken = user.idToken?.tokenString else { return nil }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            let authResult = try await FirebaseManager.shared.auth.signIn(with: credential)
            return authResult
        } catch {
            throw error
        }
    }
    
    func authenticateWithFacebook() async throws -> AuthDataResult? {
        let faceBookAuth = FacebookAuthentication()
        
        do {
            let credential = try await faceBookAuth.loginWithFacebook()
            guard let credential = credential else { return nil }
            let authResult = try await FirebaseManager.shared.auth.signIn(with: credential)
            return authResult
        } catch {
            throw error
        }
    }
    
    func authenticateWithApple(currentNonce: String?, result: Result<ASAuthorization, Error>) async throws -> AuthDataResult? {
        do {
            switch result {
                case .success(let authResults):
                    switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            guard let nonce = currentNonce else {
                                return nil
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                return nil
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                return nil
                            }
                            
                            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                            
                            let authResult = try await FirebaseManager.shared.auth.signIn(with: credential)
                            return authResult
                        default:
                            return nil
                        }
                default:
                    return nil
            }
        } catch {
            throw error
        }
    }
    
    func signOutUser() throws {
        do {
            try FirebaseManager.shared.auth.signOut()
        } catch {
            throw error
        }
    }
    
    func deleteAcount() async throws {
        do {
            try await FirebaseManager.shared.auth.currentUser?.delete()
        } catch {
            throw error
        }
    }
}
