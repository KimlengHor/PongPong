//
//  CategorySubTitle.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/8/23.
//

import SwiftUI

struct CategorySubTitle: View {
    
    let subtitle: String
    
    var body: some View {
        Text(subtitle)
            .font(FontConstants.fifteenReg)
            .foregroundColor(.gray)
    }
}

struct CategorySubTitle_Previews: PreviewProvider {
    static var previews: some View {
        CategorySubTitle(subtitle: "Hello")
    }
}
