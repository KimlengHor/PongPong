//
//  BookCover.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//
import SwiftUI

struct BookCover<Content>: View where Content: View {
  let content: Content

  var body: some View {
    content
          .frame(width: 150, height: 200)
          .aspectRatio(contentMode: .fill)
          .clipped()
          .cornerRadius(10)
          .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 3, y: 1)
  }
}
