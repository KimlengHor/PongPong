//
//  SignupView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/7/23.
//

import SwiftUI

struct SignupView: View {
    var body: some View {
        VStack(alignment: .leading) {
            NavigationSubtitle(text: "Explore the world of kid books")
            
            VStack(spacing: 10) {
                signUpWithApple
                signUpWithGoogle
                signUpWithFacebook
                signUpWithEmail
                
                Spacer()
                
                signInButton
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .navigationTitle("Sign up")
        .padding(.vertical)
        .padding(.horizontal, 24)
    }
    
    private var signUpWithApple: some View {
        CustomButton(action: {},
                     title: "Continue with Apple",
                     backgroundColor: Color(cgColor: CGColor(red: 0.02, green: 0.03, blue: 0.03, alpha: 1)),
                     image: Image("apple"))
    }
    
    private var signUpWithGoogle: some View {
        CustomButton(action: {},
                     title: "Continue with Google",
                     backgroundColor: Color(cgColor: CGColor(red: 0.87, green: 0.29, blue: 0.22, alpha: 1)),
                     image: Image("google"))
    }
    
    private var signUpWithFacebook: some View {
        CustomButton(action: {},
                     title: "Continue with Facebook",
                     backgroundColor: Color(cgColor: CGColor(red: 0.26, green: 0.40, blue: 0.70, alpha: 1)),
                     image: Image("facebook"))
    }
    
    private var signUpWithEmail: some View {
        NavCustomButton(title: "Sign up with Email",
                        backgroundColor: Color(.orange),
                        image: Image("email"),
                        destination: SignupWithEmailView())
    }
    
    private var signInButton: some View {
        NavButtonWithLeadingText(
            text: "Have an account?",
            buttonText: "Login",
            buttonColor: Color(.orange),
            destination: SigninView())
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
