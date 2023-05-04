//
//  ProfileView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/29/23.
//

import SwiftUI

struct FavoriteView: View {
    
    @StateObject var vm = FavoriteViewModel()
    @State private var showConfirmationDialog = false
    @State private var message = ""
    @State private var title = ""
    
    private enum ProfileOption {
        case logout
        case delete
    }
    
    @State private var profileOption = ProfileOption.logout
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9"]

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            CategoryTitle(text: "All your favorite books")
                            booksGridView
                                .padding(.top, 5)
                        }
                        .padding(.top)
                    }
                    .padding()
                }
                .navigationTitle("Favorite")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        menuItem
                    }
                }
                .confirmationDialog(title, isPresented: $showConfirmationDialog) {
                    Button(title, role: .destructive) {
                        if profileOption == .delete {
                            Task {
                                await vm.deleteAccount()
                            }
                        } else {
                            vm.signOutUser()
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text(message)
                }
                
                if vm.isLoading {
                    LoadingView()
                }
            }
        }
    }
    
    private var booksGridView: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(items, id: \.self) { item in
                VStack(alignment: .leading, spacing: 5) {
                    BookCover(content: Image("cover").resizable())
                    ContentTitle(text: "Pong Pong")
                    RatingView(rating: "5.0")
                }
                .foregroundColor(Color(.label))
            }
        }
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
