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
            VStack {
                if vm.isLoading {
                    LoadingView()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 15) {
                            
                            Divider()
                            
                            HorizontalBookSection(title: "Recent Books", subtitle: "Books you've not finished reading.", books: vm.recentBooks, showProgessView: true)
                                .padding(.top)
                            
                            Divider()
                            
                            HorizontalBookSection(title: "New Books", subtitle: "Explore new release books for this week.", books: vm.newBooks)
                                .padding(.top)
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                CategoryTitle(text: "More to Explore")
                                CategorySubTitle(subtitle: "Browse for all free books.")
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
                        .padding()
                    }
                }
            }
            .navigationTitle("Explore")
            .alert(isPresented: $vm.showingAlert) {
                Alert(title: Text("Something is wrong"), message: Text(vm.errorMessage), dismissButton: .default(Text("Okay")))
            }
            .refreshable {
                fetchTask = Task {
                    await vm.refetchBooks()
                }
            }
        }
        .task {
            if vm.books.count == 0 {
                await vm.fetchAllBookTypes()
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
