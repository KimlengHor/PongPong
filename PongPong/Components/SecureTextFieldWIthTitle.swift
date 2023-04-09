//
//  TextFieldWithTitle.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import SwiftUI

struct SecureTextFieldWithTitle: View {
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(title)
                .font(FontConstants.sixteenBold)
            
            SecureField(text: $text) {
                Text("Enter your \(title.lowercased())")
                    .font(FontConstants.fifteenReg)
            }
            .padding(.leading)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0.5)
                    .frame(height: 60)
            }
        }
    }
}

//struct SecureTextFieldWithTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldWithTitle(title: "", text: <#Binding<String>#>)
//    }
//}
