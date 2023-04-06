//
//  BookContentView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookContentView: View {
    
    let bookContents: [String]?
    
    @Environment(\.presentationMode) var presentationMode
    @State private var hideNavigationBar = true
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top) {
                
                contentTabView
                
                if !hideNavigationBar {
                    topNavBarView
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var contentTabView: some View {
        TabView {
            ForEach(bookContents ?? [], id: \.self) { content in
                WebImage(url: URL(string: content))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        hideNavigationBar.toggle()
                    }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    private var topNavBarView: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Text("Back")
                    .foregroundColor(.white)
            }
            .padding()
            
            Spacer()
        }
        .background(Color.black.opacity(0.5))
    }
}

struct BookContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
//        BookContentView(bookContents: [])
    }
}
