//
//  SignupView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/7/23.
//

import SwiftUI

struct SignupView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Explore the world of kid books")
                    .font(.body)
                    .foregroundColor(Color.gray)
                    .padding(.top, -10)
                    .padding(.leading, -7)
                
                VStack(spacing: 10) {
                    CustomButton(action: {},
                                 title: "Continue with Apple",
                                 backgroundColor: Color(cgColor: CGColor(red: 0.02, green: 0.03, blue: 0.03, alpha: 1)),
                                 image: Image("apple"))
                    
                    CustomButton(action: {},
                                 title: "Continue with Google",
                                 backgroundColor: Color(cgColor: CGColor(red: 0.87, green: 0.29, blue: 0.22, alpha: 1)),
                                 image: Image("google"))
                    
                    CustomButton(action: {},
                                 title: "Continue with Facebook",
                                 backgroundColor: Color(cgColor: CGColor(red: 0.26, green: 0.40, blue: 0.70, alpha: 1)),
                                 image: Image("facebook"))
                    
//                    CustomButton(action: {
//
//                    }, title: "Sign up with Email", backgroundColor: Color(.orange))
                    
                    Spacer()
                    
                    ButtonWithLeadingText(
                        text: "Have an account?",
                        buttonText: "Login",
                        buttonColor: Color(.orange),
                        action: {
                            
                        })
                }
                .padding(.top, 40)
                
                Spacer()
            }
            .navigationTitle("Sign up")
            .padding(.vertical)
            .padding(.horizontal, 24)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
