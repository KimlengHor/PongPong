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

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.isLoading {
                    LoadingView()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 15) {
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                CategoryTitle(text: "Favorite books")
                                CategorySubTitle(subtitle: "See the books you love.")
                                booksGridView
                                    .padding(.top, 5)
                            }
                            .padding(.top)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favorite")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    menuItem
                }
            }
            .confirmationDialog(title, isPresented: $showConfirmationDialog) {
                confirmationButtons
            } message: {
                Text(message)
            }
            .task {
                if vm.books.count == 0 {
                    await vm.fetchFavoriteBooks()
                }
            }
        }
    }
    
    private var confirmationButtons: some View {
        VStack {
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
        }
    }
    
    private var booksGridView: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(vm.books) { book in
                BookView(book: book)
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
