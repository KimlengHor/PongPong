//
//  HorizontalBookList.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/8/23.
//

import SwiftUI

struct HorizontalBookList: View {
    
    let books: [Book]
    var showProgessView = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(books) { book in
                    BookView(book: book, showProgessView: showProgessView)
                }
            }
            .padding(.horizontal)
        }
    }
}

//struct HorizontalBookList_Previews: PreviewProvider {
//    static var previews: some View {
//        HorizontalBookList()
//    }
//}
