//
//  CategoryTitle.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI

struct CategoryTitle: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .bold, design: .default))
    }
}

struct CategoryTitle_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTitle(text: "Hello")
    }
}
