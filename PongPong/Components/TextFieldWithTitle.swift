//
//  TextFieldWithTitle.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import SwiftUI

struct TextFieldWithTitle: View {
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text(title)
                .font(.custom("Poppins-Bold", size: 18))
            
            TextField(text: $text) {
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

//struct TextFieldWithTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldWithTitle(title: "", text: <#Binding<String>#>)
//    }
//}
