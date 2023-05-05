//
//  FeedbackView.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/5/23.
//

import SwiftUI

struct FeedbackView: View {
    
    var text: String
    var imageName: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 44, height: 44)
                .padding(.bottom, 5)
            Text(text)
        }
        .withSmallMiddleViewFomatting()
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView(text: "Added to favorites", imageName: "star.fill")
    }
}
