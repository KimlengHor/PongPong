//
//  WelcomeScreen.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/7/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Spacer()
                
                Image(ImageConstants.welcome)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                Text("Welcome to a World of Adventure: Get Started with Our Kid Book App!")
                    .font(.system(size: 24, weight: .medium, design: .serif))
                    
                Text("Let's dive into a world of imagination! Create your profile and discover exciting books in our Kid Book App for endless fun!")
                    .font(.system(size: 15, weight: .regular, design: .serif))
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 32)
                
                loginButton
                
                NavButtonWithLeadingText(
                    text: "Don't have an account?",
                    buttonText: "Sign up",
                    destination: SignupView())
            }
            .padding(.horizontal, 24)
            .padding(.vertical)
            .multilineTextAlignment(.center)
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var loginButton: some View {
        NavCustomButton(title: "Login", destination: SigninView())
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


