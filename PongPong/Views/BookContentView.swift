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
            }
        }
        .navigationBarBackButtonHidden(true)
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
                    await vm.addBookToFavorites(bookId: book?.id)
                }
            } label: {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.white)
                        .font(.title)
                    Text("Add to favorites")
                }
                .foregroundColor(.white)
            }
            .padding()
        }
        .background(Color.black.opacity(0.5))
    }
}

struct BookContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
//        BookContentView(bookContents: [])
    }
}
