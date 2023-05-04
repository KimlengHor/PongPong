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
            ButtonBodyView(title: title, backgroundColor: backgroundColor, image: image)
        }
        
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {
            
        }, title: "Login with Apple", backgroundColor: Color(.black), image: Image(systemName: "applewatch"))
    }
}

struct ButtonBodyView: View {
    
    let title: String
    let backgroundColor: Color
    var image: Image?
    
    var body: some View {
        ZStack(alignment: .leading) {
            if let image = image {
                image
                    .resizable()
                    .frame(width: 30, height: 30)
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading)
            }
            Text(title)
                .font(FontConstants.fifteenMedium)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
        }
        .background(backgroundColor)
        .foregroundColor(Color(.white))
        .cornerRadius(10)
    }
}
