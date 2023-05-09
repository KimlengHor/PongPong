//
//  BookView.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/8/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookView: View {
    
    let book: Book
    var showProgessView = false
    
    @State var showBookContentView = false
    
    var body: some View {
        Button {
            showBookContentView.toggle()
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                ZStack(alignment: .bottom) {
                    BookCover(content: WebImage(url: URL(string: book.cover ?? ""))
                        .resizable())
                    if showProgessView {
                        VStack {
                            HStack {
                                ProgressView(value: 0.5, total: 1)
                                    .scaleEffect(CGSize(width: 1, height: 1.5))
                                    .tint(Color.green)
                                Text(book.progressPercentage ?? "")
                                    .font(FontConstants.elevenSemi)
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 1)
                        }
                        .background(.ultraThinMaterial)
                        .padding(.bottom)
                    }
                }
                
                ContentTitle(text: book.title?.capitalized ?? "")
                RatingView(rating: String(book.rating ?? 0))
            }
            .foregroundColor(Color(.label))
            .fullScreenCover(isPresented: $showBookContentView, content: {
                BookContentView(book: book)
            })
        }
    }
}

//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookView()
//    }
//}
