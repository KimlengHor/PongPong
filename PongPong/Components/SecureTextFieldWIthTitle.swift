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
        VStack(alignment: .leading, spacing: 40) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
            
            SecureField(text: $text) {
                Text("Enter your \(title)")
            }
            .padding(.leading)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0.5)
                    .frame(height: 70)
            }
        }
    }
}

//struct SecureTextFieldWithTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldWithTitle(title: "", text: <#Binding<String>#>)
//    }
//}
