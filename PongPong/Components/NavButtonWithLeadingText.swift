//
//  ButtonWithLeadingText.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/7/23.
//

import SwiftUI

struct NavButtonWithLeadingText<Destination: View>: View {
    let text: String
    let buttonText: String
    var buttonColor: Color = ColorConstants.primaryColor
    let destination: Destination
    
    var body: some View {
        HStack {
            Text(text)
                .font(FontConstants.fifteenMedium)
            
            NavigationLink(destination: destination) {
                Text(buttonText)
                    .font(FontConstants.fifteenSemi)
                    .foregroundColor(buttonColor)
            }
        }
    }
}

//struct NavButtonWithLeadingText_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonWithLeadingText(
//            text: "Don't have an account",
//            buttonText: "Sign up",
//    }
//}


