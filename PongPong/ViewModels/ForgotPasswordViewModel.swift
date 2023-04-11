//
//  ForgotPasswordViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/11/23.
//

import Foundation
import SwiftUI

@MainActor
class ForgotPasswordViewModel: ObservableObject {
    
    private let authMananger = FirebaseAuthManager()
    
    @Published var errorMessage = ""
    @Published var showingAlert = false
    
    func resetPassword(email: String) async {
        do {
            try await authMananger.forgotPassword(email: email)
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
}
