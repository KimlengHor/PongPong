//
//  ButtonWithLeadingText.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/7/23.
//

import SwiftUI

struct ButtonWithLeadingText: View {
    let text: String
    let buttonText: String
    let buttonColor: Color
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(text)
                .font(.headline)
            
            Button(action: action) {
                Text(buttonText)
                    .font(.headline)
                    .foregroundColor(buttonColor)
            }
        }
    }
}

struct ButtonWithLeadingText_Previews: PreviewProvider {
    static var previews: some View {
        ButtonWithLeadingText(
            text: "Don't have an account",
            buttonText: "Sign up",
            buttonColor: Color(.orange),
            action: {
                
            })
    }
}


