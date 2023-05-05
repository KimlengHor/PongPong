//
//  HomeView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var vm = HomeViewModel()
    @State var fetchTask: Task<(), Never>?
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            CategoryTitle(text: "Recent Books")
                            recentBookList
                                .frame(height: 255)
                                .padding(.top, 5)
                        }
                        .padding(.top)
                                            
                        Divider()
                        
                        VStack(alignment: .leading) {
                            CategoryTitle(text: "All Books")
                            VerticalBookList(books: vm.books)
                                .padding(.top, 5)
                        }
                        .padding(.top)
                        
                        if vm.isFetchingMore {
                            moreButton
                                .padding(.top)
                        }
                        
                        Spacer()
                    }
                    .navigationTitle("Explore")
                    .padding()
                    .alert(isPresented: $vm.showingAlert) {
                        Alert(title: Text("Something is wrong"), message: Text(vm.errorMessage), dismissButton: .default(Text("Okay")))
                    }
                }
                .refreshable {
                    fetchTask = Task {
                        await vm.refetchBooks()
                    }
                }
                
                if vm.isLoading {
                    LoadingView()
                }
            }
        }
        .task {
            if vm.books.count == 0 {
                await vm.fetchBooks()
            }
        }
        .onDisappear {
            fetchTask?.cancel()
        }
    }
    
    private var moreButton: some View {
        CustomButton(action: {
            fetchTask = Task {
                await vm.fetchBooks()
            }
        }, title: "More books", backgroundColor: .orange)
    }
    
    private var recentBookList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(1...10, id: \.self) {_ in
//                    NavigationLink(destination: BookContentView()) {
                        VStack(alignment: .leading, spacing: 5) {
                            BookCover(content: Image("cover").resizable())
                            ContentTitle(text: "Pong Pong")
                            RatingView(rating: "5.0")
                        }
                        .foregroundColor(Color(.label))
//                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
