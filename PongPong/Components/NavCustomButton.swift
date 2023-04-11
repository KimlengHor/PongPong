//
//  NavCustomButton.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/11/23.
//

import SwiftUI

struct NavCustomButton<Destination: View>: View {
    let title: String
    let backgroundColor: Color
    var image: Image?
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            ButtonBodyView(title: title, backgroundColor: backgroundColor, image: image)
        }
        
    }
}

//struct NavCustomButton_Previews: PreviewProvider {
//    static var previews: some View {
//        NavCustomButton()
//    }
//}
