//
//  HorizontalBookSection.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/8/23.
//

import SwiftUI

struct HorizontalBookSection: View {
    
    let title: String
    let subtitle: String
    let books: [Book]
    
    var showProgessView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            CategoryTitle(text: title)
            CategorySubTitle(subtitle: subtitle)
            HorizontalBookList(books: books, showProgessView: showProgessView)
                .frame(height: 255)
                .padding(.top, 5)
        }
    }
}

//struct HorizontalBookSection_Previews: PreviewProvider {
//    static var previews: some View {
//        HorizontalBookSection(title: "", subtitle: "")
//    }
//}
