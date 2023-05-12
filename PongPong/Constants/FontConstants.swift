//
//  FontConstants.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/9/23.
//

import Foundation
import SwiftUI

//enum Poppins: String {
//    case bold = "Poppins-Bold"
//    case medium = "Poppins-Medium"
//    case regualr = "Poppins-Regular"
//    case semibold = "Poppins-SemiBold"
//}
private let fontDesign = Font.Design.serif

struct FontConstants {
    //good fonts are between 15 - 19
    
    //regular
    static let fifteenReg = Font.system(size: 15, weight: .regular, design: fontDesign)
    
    //medium
    static let fifteenMedium = Font.system(size: 15, weight: .medium, design: fontDesign)
    
    //semi-bold
    static let fifteenSemi = Font.system(size: 15, weight: .semibold, design: fontDesign)
    static let elevenSemi = Font.system(size: 11, weight: .semibold, design: fontDesign)
    static let eighteenSemi = Font.system(size: 18, weight: .semibold, design: fontDesign)
    static let twentySemi = Font.system(size: 20, weight: .semibold, design: fontDesign)
    static let twentyThreeSemi = Font.system(size: 23, weight: .semibold, design: fontDesign)
    
    //bold
    static let eighteenBold = Font.system(size: 18, weight: .bold, design: fontDesign)
    static let sixteenBold = Font.system(size: 16, weight: .bold, design: fontDesign)
    static let thirtyFiveBold = Font.system(size: 35, weight: .bold, design: fontDesign)
}
