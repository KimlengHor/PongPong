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
    var backgroundColor: Color = ColorConstants.primaryColor
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
        HStack(alignment: .center) {
            if let image = image {
                image
                    .resizable()
                    .frame(width: 15, height: 15)
                    .aspectRatio(contentMode: .fit)
            }
            Text(title)
                .font(.system(size: 23, weight: .medium))

        }
        .frame(height: 56)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .foregroundColor(Color(.white))
        .cornerRadius(10)
    }
}
