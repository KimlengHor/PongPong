//
//  VerticalBookList.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/6/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct VerticalBookList: View {
    
    let books: [Book]
//    @State private var showBookContentView = false
    @State private var selectedBook: Book?
    
    var body: some View {
        ForEach(books) { book in
            Button {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    // Code to be executed after the delay
                    selectedBook = book
//                    showBookContentView.toggle()
                }
            } label: {
                HStack(spacing: 20) {
                    BookCover(content: WebImage(url: URL(string: book.cover ?? ""))
                        .resizable())

                    VStack(alignment: .leading, spacing: 5) {
                        ContentTitle(text: book.capitalizedTitle() ?? "")
                        VStack(alignment: .leading, spacing: 13) {
                            RatingView(rating: String(book.rating ?? 0))
                            Text(book.description ?? "")
                                .font(FontConstants.fifteenReg)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                        }
                    }

                    Spacer()
                }
            }
            .foregroundColor(Color(.label))
        }
        .fullScreenCover(item: $selectedBook) { BookContentView(book: $0) }
    }
}

struct VerticalBookList_Previews: PreviewProvider {
    static var previews: some View {
        VerticalBookList(books: [])
    }
}
