//
//  SignupWithEmailView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/11/23.
//

import SwiftUI

struct SignupWithEmailView: View {
    
    @State private var emailAddress = ""
    @State private var password = ""
    @State private var isLoading = false
    
    @StateObject var vm = SignupViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                NavigationSubtitle(text: "Create an account with an email address")
                
                VStack(spacing: 40) {
                    TextFieldWithTitle(title: "Email", type: .emailAddress, text: $emailAddress)
                    SecureTextFieldWithTitle(title: "Password", text: $password)
                }
                .padding(.top, 20)
                
                Spacer()
                
                CustomButton(action: {
                    Task {
                        isLoading = true
                        await vm.signupWithEmail(email: emailAddress, password: password)
                        isLoading = false
                    }
                }, title: "Sign up", backgroundColor: Color.orange)
            }
            .navigationTitle("Sign up")
            .padding(.vertical)
            .padding(.horizontal, 24)
            .alert(isPresented: $vm.showingAlert) {
                Alert(title: Text("Something is wrong"), message: Text(vm.errorMessage), dismissButton: .default(Text("Okay")))
            }
            
            if isLoading {
                LoadingView(text: "Signing up")
            }
        }
    }
}

struct SignupWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignupWithEmailView()
            .environmentObject(SignupViewModel())
    }
}
