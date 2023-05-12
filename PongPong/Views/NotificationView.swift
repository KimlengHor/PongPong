//
//  NotificationView.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/12/23.
//

import SwiftUI

struct NotificationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var vm = NotificationViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()

            Image(ImageConstants.notification)
                .resizable()
                .aspectRatio(contentMode: .fit)
    
            Spacer()
            
            Text("Keep your kids reading!")
                .font(.system(size: 24, weight: .medium, design: .serif))
                
            Text("Turn on notifications to be the first to know when a new kid's book is available.")
                .font(.system(size: 15, weight: .regular, design: .serif))
                .foregroundColor(Color.gray)
                .padding(.bottom, 32)
            
            notNowButton
            notifyMeButton
        }
        .padding(.horizontal, 24)
        .padding(.vertical)
        .multilineTextAlignment(.center)
        .alert(isPresented: $vm.showingAlert) {
            Alert(title: Text("Something is wrong"), message: Text(vm.errorMessage), dismissButton: .default(Text("Okay")))
        }
    }
    
    private var notNowButton: some View {
        CustomButton(action: {
            presentationMode.wrappedValue.dismiss()
        }, title: "Not right now", backgroundColor: Color.secondary)
    }
    
    private var notifyMeButton: some View {
        CustomButton(action: {
            Task {
                await vm.getNotificationPermission()
                if vm.success {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }, title: "Notify me")
    }
    
    
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
