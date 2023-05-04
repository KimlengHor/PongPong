//
//  ProfileView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/29/23.
//

import SwiftUI

struct FavoriteView: View {
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9"]

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        CategoryTitle(text: "All your favorite books")
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
                        .padding(.top, 5)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Favorite")
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            
                        } label: {
                            Text("Log out")
                        }

                        Button {
                            
                        } label: {
                            Text("Delete account")
                        }
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
