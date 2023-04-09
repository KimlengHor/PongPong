//
//  ContentTitle.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI

struct ContentTitle: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(FontConstants.sixteenBold)
    }
}

struct ContentTitle_Previews: PreviewProvider {
    static var previews: some View {
        ContentTitle(text: "")
    }
}
