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
    
    var body: some View {
        ForEach(books) { book in
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

struct VerticalBookList_Previews: PreviewProvider {
    static var previews: some View {
        VerticalBookList(books: [])
    }
}
