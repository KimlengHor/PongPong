//
//  CustomButton.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/7/23.
//

import SwiftUI

struct CustomButton: View {
    
    let action: () -> Void
    let title: String
    let backgroundColor: Color
    var image: Image?
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .leading) {
                if let image = image {
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading)
                }
                Text(title)
                    .font(.custom("Poppins-Bold", size: 16))
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
            }
        }
        .background(backgroundColor)
        .foregroundColor(Color(.white))
        .cornerRadius(10)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {
            
        }, title: "Login with Apple", backgroundColor: Color(.black), image: Image(systemName: "applewatch"))
    }
}
