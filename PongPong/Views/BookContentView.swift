//
//  BookContentView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookContentView: View {
    
    let book: Book?
    
    @Environment(\.presentationMode) var presentationMode
    @State private var hideNavigationBar = true
    
    @StateObject private var vm = BookContentViewModel()
    
    var body: some View {
        
        NavigationView {
            ZStack() {
                
                contentTabView
                
                if !hideNavigationBar {
                    VStack {
                        topNavBarView
                        Spacer()
                        bottomNavBarView
                    }
                }
                
                if vm.isLoading {
                    LoadingView()
                }
                
                if vm.showFeedbackView {
                    feedbackView
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            if book?.isFavorite == nil {
                await vm.checkIfBookInFavorites(book: book)
            }
        }
    }
    
    private var contentTabView: some View {
        TabView {
            ForEach(book?.contents ?? [], id: \.self) { content in
                WebImage(url: URL(string: content))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        hideNavigationBar.toggle()
                    }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    private var topNavBarView: some View {
        HStack {
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .padding()
        }
        .background(Color.black.opacity(0.5))
    }
    
    private var bottomNavBarView: some View {
        HStack {
            Spacer()
            
            Button {
                Task {
                    if book?.isFavorite == true {
                        await vm.removeBookFromFavorites(book: book)
                    } else {
                        await vm.addBookToFavorites(book: book)
                    }
                    hideNavigationBar = true
                }
            } label: {
                HStack {
                    Image(systemName: book?.isFavorite == true
                          ? "star.slash.fill"
                          : "star.fill")
                        .foregroundColor(.white)
                        .font(.title)
                    Text(book?.isFavorite == true
                         ? "Remove from favorites"
                         : "Add to favorites")
                }
                .foregroundColor(.white)
            }
            .padding()
        }
        .background(Color.black.opacity(0.5))
    }
    
    private var feedbackView: some View {
        FeedbackView(text: book?.isFavorite == true ? "Added to favorites" : "Removed from favorites",
                     imageName: book?.isFavorite == true ? "star.fill" : "star.slash.fill")
            .transition(.fade(duration: 0.2))
    }
}

struct BookContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
//        BookContentView(bookContents: [])
    }
}
