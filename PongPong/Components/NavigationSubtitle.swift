//
//  NavigationSubtitle.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import SwiftUI

struct NavigationSubtitle: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.custom("Poppins-Regular", size: 15))
            .font(.body)
            .foregroundColor(Color.gray)
            .padding(.top, -10)
//            .padding(.leading, -7)
    }
}

struct NavigationSubtitle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSubtitle(text: "")
    }
}
