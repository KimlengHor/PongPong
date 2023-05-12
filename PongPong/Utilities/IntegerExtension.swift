//
//  IntegerExtension.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/10/23.
//

import Foundation

extension Int {
    func calculateProgress(numPages: Int) -> Float {
        let progress = Float(self + 1) / Float(numPages)
        return progress
    }
}
