//
//  HomeView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @State private var searchText: String = ""
    @StateObject private var vm = HomeViewModel()
    @State var searchTask: Task<(), Never>?
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    searchTextFiled
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        CategoryTitle(text: "Recent Books")
                        recentBookList
                            .frame(height: 255)
                            .padding(.top, 7)
                    }
                    .padding(.top)
                                        
                    Divider()
                    
                    VStack(alignment: .leading) {
                        CategoryTitle(text: "All Books")
                        allBookList
                            .padding(.top, 7)
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .navigationTitle("Explore")
                .padding()
                .alert(isPresented: $vm.showingAlert) {
                    Alert(title: Text("Something is wrong"), message: Text(vm.errorMessage), dismissButton: .default(Text("Okay")))
                }
            }
        }
        .task {
            await vm.fetchBooks()
        }
        .onDisappear {
            searchTask?.cancel()
        }
    }
    
    private var searchTextFiled: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .renderingMode(.original)
                .foregroundColor(.gray)
            TextField(text: $searchText) {
                Text("Find the book")
            }
            .submitLabel(.search)
            .onSubmit {
                searchTask = Task {
                    await vm.searchBooks(searchText: searchText)
                }
            }
        }
        .padding(.leading)
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var recentBookList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(1...10, id: \.self) {_ in
                    NavigationLink(destination: BookContentView(bookContents: [])) {
                        VStack(alignment: .leading, spacing: 5) {
                            BookCover(content: Image("cover").resizable())
                            ContentTitle(text: "Pong Pong")
                            RatingView(rating: "5.0")
                        }
                        .foregroundColor(Color(.label))
                    }
                }
            }
        }
    }
    
    private var allBookList: some View {
        ForEach(vm.books) { book in
            NavigationLink(destination: BookContentView(bookContents: book.contents)) {
                HStack(spacing: 20) {
                    BookCover(content: WebImage(url: URL(string: book.cover ?? ""))
                        .resizable())
                    
                    VStack(alignment: .leading, spacing: 5) {
                        ContentTitle(text: book.capitalizedTitle() ?? "")
                        VStack(alignment: .leading, spacing: 13) {
                            RatingView(rating: String(book.rating ?? 0))
                            Text(book.description ?? "")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    Spacer()
                }
            }
            .foregroundColor(Color(.label))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
