//
//  HepticMananger.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/5/23.
//

import SwiftUI

class HepticManager {
    static let instance = HepticManager() //Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
