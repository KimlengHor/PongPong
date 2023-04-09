//
//  RatingView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI

struct RatingView: View {
    
    let rating: String
    
    var body: some View {
        HStack(spacing: 5){
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(rating)
                .font(FontConstants.fifteenReg)
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: "")
    }
}
