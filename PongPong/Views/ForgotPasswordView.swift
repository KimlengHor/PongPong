//
//  ForgotPasswordView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/11/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var emailAddress = ""
    @State private var isLoading = false
    
    @ObservedObject var vm = ForgotPasswordViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                NavigationSubtitle(text: "No worries, we'll send you reset instructions")
                
                TextFieldWithTitle(title: "Email", type: .emailAddress, text: $emailAddress)
                    .padding(.top, 20)
                
                Spacer()
                
                CustomButton(action: {
                    Task {
                        isLoading = true
                        await vm.resetPassword(email: emailAddress)
                        isLoading = false
                    }
                }, title: "Reset password", backgroundColor: Color.orange)
            }
            .navigationTitle("Forgot password?")
            .padding(.vertical)
            .padding(.horizontal, 24)
            .alert(isPresented: $vm.showingAlert) {
                Alert(title: Text("Something is wrong"), message: Text(vm.errorMessage), dismissButton: .default(Text("Okay")))
            }
            
            if isLoading {
                LoadingView(text: "Sending")
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
