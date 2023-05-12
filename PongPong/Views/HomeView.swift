//
//  HomeView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI
import StoreKit
import UserNotifications

struct HomeView: View {
    
    @Environment(\.requestReview) var requestReview

    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var pongPongViewModel: PongPongViewModel
    
    @State var fetchTask: Task<(), Never>?
    
    @State private var showConfirmationDialog = false
    @State private var message = ""
    @State private var title = ""
    @State private var alreadyShowNotificationModel = false
    @State private var showNotificationModel = false
    
    private enum ProfileOption {
        case logout
        case delete
    }
    
    @State private var profileOption = ProfileOption.logout
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.isLoading && vm.books.isEmpty {
                    LoadingView()
                } else {
                    ZStack {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 15) {
                                
                                Divider()
                                
                                if !vm.recentBooks.isEmpty {
                                    HorizontalBookSection(title: "Recent Books", subtitle: "Books you've not finished reading.", books: vm.recentBooks, showProgessView: true)
                                        .padding(.top)
                                    
                                    Divider()
                                }
                                
                                HorizontalBookSection(title: "New Books", subtitle: "Explore new release books for this week.", books: vm.newBooks)
                                    .padding(.top)
                                
                                Divider()
                                
                                VStack(alignment: .leading) {
                                    CategoryTitle(text: "More to Explore")
                                    CategorySubTitle(subtitle: "Browse for all free books.")
                                    VerticalBookList(books: vm.books)
                                        .padding(.top, 5)
                                    
                                    if vm.isFetchingMore {
                                        moreButton
                                            .padding(.top)
                                    }
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                        
                        if vm.isLoading {
                            LoadingView()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Explore")
                        .font(FontConstants.thirtyFiveBold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    menuItem
                }
            }
            .confirmationDialog(title, isPresented: $showConfirmationDialog) {
                confirmationButtons
            } message: {
                Text(message)
            }
            .alert(isPresented: $vm.showingAlert) {
                Alert(title: Text("Something is wrong"), message: Text(vm.errorMessage), dismissButton: .default(Text("Okay")))
            }
            .refreshable {
                fetchTask = Task {
                    await vm.refetchBooks()
                }
            }
            .sheet(isPresented: $showNotificationModel) {
                NotificationView()
            }
        }
        .task {
            if vm.books.count == 0 {
                await vm.fetchAllBookTypes()
            }
        }
        .onAppear {
            requestReviewFromUser()
            requestNotificationFromUser()
        }
        .onDisappear {
            fetchTask?.cancel()
        }
    }
    
    private func requestReviewFromUser() {
        let shouldShowReview = vm.canRequestReview()
        if shouldShowReview {
            requestReview()
        }
    }
    
    private func requestNotificationFromUser() {
        if alreadyShowNotificationModel == false && vm.canRequestNotification() == true {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .notDetermined {
                    showNotificationModel = true
                    alreadyShowNotificationModel = true
                }
            }
        }
    }
    
    private var moreButton: some View {
        CustomButton(action: {
            fetchTask = Task {
                await vm.fetchBooks()
            }
        }, title: "More books", backgroundColor: ColorConstants.primaryColor)
    }
    
    private var menuItem: some View {
        Menu {
            logoutButton
            deleteAccountButton
        } label: {
            Image(systemName: "person.circle.fill")
                .resizable()
                .padding(8)
                .frame(width: 44, height: 44)
                .foregroundColor(Color.black)
        }
    }
    
    private var logoutButton: some View {
        Button(role: .destructive) {
            profileOption = .logout
            title = "Log out"
            message = "Are you sure you want to log out of the application?"
            showConfirmationDialog = true
        } label: {
            Text("Log out")
        }
    }
    
    private var deleteAccountButton: some View {
        Button(role: .destructive) {
            profileOption = .delete
            title = "Delete account"
            message = "Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted."
            showConfirmationDialog = true
        } label: {
            Text("Delete account")
        }
    }
    
    private var confirmationButtons: some View {
        VStack {
            Button(title, role: .destructive) {
                if profileOption == .delete {
                    Task {
                        await vm.deleteAccount()
                        pongPongViewModel.checkForCurrentUser()
                    }
                } else {
                    vm.signOutUser()
                    pongPongViewModel.checkForCurrentUser()
                }
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
