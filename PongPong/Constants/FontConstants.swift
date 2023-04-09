//
//  FontConstants.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/9/23.
//

import Foundation
import SwiftUI

enum Poppins: String {
    case bold = "Poppins-Bold"
    case medium = "Poppins-Medium"
    case regualr = "Poppins-Regular"
    case semibold = "Poppins-SemiBold"
}

struct FontConstants {
    //good fonts are between 15 - 19
    
    //regular
    static let fifteenReg = Font.custom(Poppins.regualr.rawValue, size: 15)
    
    //medium
    static let fifteenMedium = Font.custom(Poppins.medium.rawValue, size: 15)
    static let fifteenSemi = Font.custom(Poppins.semibold.rawValue, size: 15)
    
    //semi-bold
    static let eighteenSemi = Font.custom(Poppins.semibold.rawValue, size: 18)
    
    //bold
    static let eighteenBold = Font.custom(Poppins.bold.rawValue, size: 18)
    static let sixteenBold = Font.custom(Poppins.bold.rawValue, size: 16)
}
