//
//  SmallMiddleViewModifier.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/5/23.
//

import SwiftUI

struct SmallMiddleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 3, y: 2)
            .font(FontConstants.fifteenReg)
    }
}

extension View {
    func withSmallMiddleViewFomatting() -> some View {
        modifier(SmallMiddleViewModifier())
    }
}
