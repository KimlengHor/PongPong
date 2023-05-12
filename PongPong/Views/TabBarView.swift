//
//  TabBarView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/6/23.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var favoriteViewModel = FavoriteViewModel()
    
    @State private var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            FavoriteView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorite")
                }
                .tag(2)
        }
        .accentColor(Color(.label))
        .environmentObject(homeViewModel)
        .environmentObject(favoriteViewModel)
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
