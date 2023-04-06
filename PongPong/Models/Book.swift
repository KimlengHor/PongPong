//
//  Book.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/5/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Book: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    let contents: [String]?
    let cover: String?
    let title: String?
    let description: String?
    let rating: Float?
    let timestamp: Date?
    
    func capitalizedTitle() -> String? {
        return title?.capitalized
    }
}

