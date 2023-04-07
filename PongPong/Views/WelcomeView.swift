//
//  WelcomeScreen.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/7/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            Image("illustration")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            Text("Welcome to a World of Adventure: Get Started with Our Kid Book App!")
                .font(.system(size: 25, weight: .bold))
            Text("Let's dive into a world of imagination! Create your profile and discover exciting books in our Kid Book App for endless fun!")
                .font(.body)
                .foregroundColor(Color.gray)
                .padding(.bottom, 32)
            
            loginButton
            
            ButtonWithLeadingText(
                text: "Don't have an account?",
                buttonText: "Sign up",
                buttonColor: Color(.orange),
                action: {
                    
                })
        }
        .padding(.horizontal, 24)
        .padding(.vertical)
        .multilineTextAlignment(.center)
    }
    
    private var loginButton: some View {
        CustomButton(action: {
            
        }, title: "Login", backgroundColor: Color(.orange))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


