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
            .font(FontConstants.fifteenReg)
            .font(.body)
            .foregroundColor(Color.gray)
            .padding(.top, -15)
//            .padding(.leading, -7)
    }
}

struct NavigationSubtitle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSubtitle(text: "")
    }
}
