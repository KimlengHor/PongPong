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
        }
        .withSmallMiddleViewFomatting()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
