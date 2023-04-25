//
//  AppleAuthentication.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/25/23.
//

import Foundation
import CryptoKit
import AuthenticationServices

final class AppleAuthentication {
    
    var currentNonce: String?
    
    init(currentNonce: String? = nil) {
        self.currentNonce = randomNonceString()
    }
    
    private func randomNonceString(length: Int = 32) -> String? {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            return nil
        }

        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }

      return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()

        return hashString
    }
    
    func appleButtonOnRequest(request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.email]
        if let nonce = currentNonce {
            request.nonce = sha256(nonce)
        } else {
            return
        }
    }
}
