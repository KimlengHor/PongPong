//
//  SearchView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/6/23.
//

import SwiftUI

struct SearchView: View {
    
    enum Field: Hashable {
        case searchText
    }
    @FocusState private var focusedField: Field?
    
    @State var searchTask: Task<(), Never>?
    @State private var searchText: String = ""
    @State private var categoryTitle: String = "Discover"
    
    @StateObject var vm = SearchViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.isLoading {
                    LoadingView()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            searchTextFiled
                                .onDisappear {
                                    searchTask?.cancel()
                                }
                                .focused($focusedField, equals: .searchText)
                            
                            Divider()
                            
                            if let books = vm.books {
                                if books.isEmpty {
                                    notFoundView
                                } else {
                                    VStack(alignment: .leading) {
                                        CategoryTitle(text: categoryTitle)
                                        VerticalBookList(books: books)
                                            .padding(.top, 7)
                                    }.padding(.top)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .scrollDismissesKeyboard(.immediately)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Search")
                        .font(FontConstants.thirtyFiveBold)
                }
            }
        }
        .task {
            if vm.books == nil || vm.books?.isEmpty == true {
                searchText = ""
                categoryTitle = "Discover"
                await vm.searchBooks(searchText: searchText)
                focusedField = .searchText
            }
        }
    }
    
    private var notFoundView: some View {
        VStack {
            Image(ImageConstants.notFound)
            CategoryTitle(text: "Oops!")
            CategorySubTitle(subtitle: "We cannot find the book you were searching for.")
                .frame(width: 200)
                .multilineTextAlignment(.center)
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
                    categoryTitle = "Results"
                    await vm.searchBooksAgain(searchText: searchText)
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
