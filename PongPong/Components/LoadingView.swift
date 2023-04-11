//
//  LoadingView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/10/23.
//

import SwiftUI

struct LoadingView: View {
    
    var text: String = "Loading"
    
    var body: some View {
        ProgressView() {
            Text(text)
                .font(FontConstants.fifteenReg)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 3, y: 2)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
