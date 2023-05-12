//
//  PongPongViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/11/23.
//

import Foundation

class PongPongViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    
    init() {
       checkForCurrentUser()
    }
    
    func checkForCurrentUser() {
        isLoggedIn = FirebaseManager.shared.auth.currentUser != nil
    }
}
