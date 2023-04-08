//
//  SigninView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import SwiftUI

struct SigninView: View {
    
    @State var emailAddress: String = ""
    @State var password: String = ""
    
    @ObservedObject var vm = SigninViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    NavigationSubtitle(text: "Choose one of the options to log in")
                    
                    VStack(spacing: 40) {
                        TextFieldWithTitle(title: "Email", text: $emailAddress)
                        SecureTextFieldWithTitle(title: "Password", text: $password)
                    }
                    .padding(.top, 30)
                    
                    VStack(spacing: 20) {
                        loginButton
                        forgotPasswordButton
                        
                        ZStack {
                            Divider()
                            Text("OR")
                                .frame(width: 50)
                                .font(.body)
                                .background(Color(.white))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 40)
                    
                    VStack(spacing: 10) {
                        signInWithApple
                        signInWithGoogle
                        signInWithFacebook
                        
                        //                    CustomButton(action: {
                        //
                        //                    }, title: "Sign up with Email", backgroundColor: Color(.orange))
                        
                        signUpButton
                        .padding(.top, 20)
                    }
                    .padding(.top, 20)
                }
                .navigationTitle("Sign in")
                .padding(.vertical)
                .padding(.horizontal, 24)
            }
        }
    }
    
    private var loginButton: some View {
        CustomButton(action: {
            Task {
                await vm.signInUser(email: emailAddress, password: password)
            }
        }, title: "Login", backgroundColor: .orange)
    }
    
    private var forgotPasswordButton: some View {
        Button {
            
        } label: {
            Text("Forgot your pasword?")
                .font(.headline)
                .foregroundColor(.black)
        }
    }
    
    private var signInWithApple: some View {
        CustomButton(action: {},
                     title: "Continue with Apple",
                     backgroundColor: Color(cgColor: CGColor(red: 0.02, green: 0.03, blue: 0.03, alpha: 1)),
                     image: Image("apple"))
    }
    
    private var signInWithGoogle: some View {
        CustomButton(action: {},
                     title: "Continue with Google",
                     backgroundColor: Color(cgColor: CGColor(red: 0.87, green: 0.29, blue: 0.22, alpha: 1)),
                     image: Image("google"))
    }
    
    private var signInWithFacebook: some View {
        CustomButton(action: {},
                     title: "Continue with Facebook",
                     backgroundColor: Color(cgColor: CGColor(red: 0.26, green: 0.40, blue: 0.70, alpha: 1)),
                     image: Image("facebook"))
    }
    
    private var signUpButton: some View {
        ButtonWithLeadingText(
            text: "Don't have an account?",
            buttonText: "Sign up",
            buttonColor: Color(.orange),
            action: {
                
            })
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}




