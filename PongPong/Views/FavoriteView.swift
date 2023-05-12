//
//  ProfileView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/29/23.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var vm: FavoriteViewModel
    
    @Binding var tabSelection: Int

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
                            
                            VStack {
                                if vm.books.isEmpty {
                                    noFavoritesView
                                } else {
                                    VStack(alignment: .leading) {
                                        CategoryTitle(text: "Favorite books")
                                        CategorySubTitle(subtitle: "Your most loved books.")
                                        booksGridView
                                            .padding(.top, 5)
                                    }
                                }
                            }
                            .padding(.top)
                                
                        }
                        .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Favorite")
                        .font(FontConstants.thirtyFiveBold)
                }
            }
            .task {
                if vm.books.count == 0 {
                    await vm.fetchFavoriteBooks()
                }
            }
        }
    }
    
    private var noFavoritesView: some View {
        VStack {
            Image(ImageConstants.favExplore)
            CustomButton(action: {
                tabSelection = 0
            }, title: "Start Exploring")
            .frame(width: 250)
        }
    }
    
    private var booksGridView: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(vm.books) { book in
                BookView(book: book)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
