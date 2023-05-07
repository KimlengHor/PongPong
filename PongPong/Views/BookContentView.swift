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
            await vm.checkIfBookInFavorites(book: book)
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
                    if vm.isBookFavorite == true {
                        await vm.removeBookFromFavorites(bookId: book?.id)
                    } else {
                        await vm.addBookToFavorites(bookId: book?.id)
                    }
                    hideNavigationBar = true
                }
            } label: {
                HStack {
                    Image(systemName: vm.favButtonImageName)
                        .foregroundColor(.white)
                        .font(.title)
                    Text(vm.favButtonText)
                }
                .foregroundColor(.white)
            }
            .padding()
        }
        .background(Color.black.opacity(0.5))
    }
    
    private var feedbackView: some View {
        FeedbackView(text: vm.feedbackText,
                     imageName: vm.feedbackImageName)
            .transition(.fade(duration: 0.2))
    }
}

struct BookContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
//        BookContentView(bookContents: [])
    }
}
