//
//  SigninView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/8/23.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct SigninView: View {
    
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var shouldPresentTabBarView = false
    
    @StateObject var vm = SigninViewModel()
    
    let appleAuth = AppleAuthentication()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    NavigationSubtitle(text: "Choose one of the options to log in")
                    
                    VStack(spacing: 40) {
                        TextFieldWithTitle(title: "Email", type: .emailAddress, text: $emailAddress)
                        SecureTextFieldWithTitle(title: "Password", text: $password)
                    }
                    .padding(.top, 20)
                    
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
                    .padding(.top, 30)
                    
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
            .alert(isPresented: $vm.showingAlert) {
                Alert(title: Text("Something is wrong"), message: Text(vm.errorMessage), dismissButton: .default(Text("Okay")))
            }
            
            if vm.isLoading {
                LoadingView(text: "Signing in")
            }
        }
        .fullScreenCover(isPresented: $shouldPresentTabBarView) {
            TabBarView()
        }
    }
    
    private func goToTabBarView() {
        if vm.user != nil {
            shouldPresentTabBarView = true
        }
    }
    
    private var loginButton: some View {
        CustomButton(action: {
            Task {
                await vm.signInUser(email: emailAddress, password: password)
                goToTabBarView()
            }
        }, title: "Login", backgroundColor: .orange)
    }
    
    private var forgotPasswordButton: some View {
        NavigationLink(destination: ForgotPasswordView()) {
            Text("Forgot your pasword?")
                .font(FontConstants.fifteenSemi)
                .foregroundColor(.black)
        }
    }
    
    private var signInWithApple: some View {
        SignInWithAppleButton(.continue) { request in
            appleAuth.appleButtonOnRequest(request: request)
        } onCompletion: { result in
            Task {
                await vm.signInWithApple(currentNonce: appleAuth.currentNonce, result: result)
                goToTabBarView()
            }
        }
        .cornerRadius(10)
        .frame(height: 60)
//        CustomButton(action: {},
//                     title: "Continue with Apple",
//                     backgroundColor: Color(cgColor: CGColor(red: 0.02, green: 0.03, blue: 0.03, alpha: 1)),
//                     image: Image("apple"))
    }
    
    private var signInWithGoogle: some View {
        CustomButton(action: {
            Task {
                await vm.signInWithGoogle()
                goToTabBarView()
            }
        },
                     title: "Continue with Google",
                     backgroundColor: Color(cgColor: CGColor(red: 0.87, green: 0.29, blue: 0.22, alpha: 1)),
                     image: Image("google"))
    }
    
    private var signInWithFacebook: some View {
        CustomButton(action: {
            Task {
                await vm.signInWithFacebook()
                goToTabBarView()
            }
        },
                     title: "Continue with Facebook",
                     backgroundColor: Color(cgColor: CGColor(red: 0.26, green: 0.40, blue: 0.70, alpha: 1)),
                     image: Image("facebook"))
    }
    
    private var signUpButton: some View {
        NavButtonWithLeadingText(
            text: "Don't have an account?",
            buttonText: "Sign up",
            buttonColor: Color(.orange),
            destination: SignupView())
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}

