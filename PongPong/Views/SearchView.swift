//
//  SearchView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/6/23.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchTask: Task<(), Never>?
    @State private var searchText: String = ""
    
    @StateObject var vm = SearchViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    searchTextFiled
                        .onDisappear {
                            searchTask?.cancel()
                        }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        CategoryTitle(text: "Results")
                        VerticalBookList(books: vm.books)
                            .padding(.top, 7)
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Search")
            }
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
