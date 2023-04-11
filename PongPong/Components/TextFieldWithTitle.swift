//
//  TextFieldWithTitle.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import SwiftUI

struct TextFieldWithTitle: View {
    
    let title: String
    var type: UIKeyboardType = .default
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(title)
                .font(FontConstants.sixteenBold)
            
            TextField(text: $text) {
                Text("Enter your \(title.lowercased())")
                    .font(FontConstants.fifteenReg)
            }
            .keyboardType(type)
            .padding(.leading)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0.5)
                    .frame(height: 60)
            }
        }
    }
}

//struct TextFieldWithTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldWithTitle(title: "", text: <#Binding<String>#>)
//    }
//}
