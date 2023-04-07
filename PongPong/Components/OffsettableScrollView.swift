//
//  OffsettableScrollView.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/7/23.
//

import Foundation
import SwiftUI

private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

struct OffsettableScrollView<T: View>: View {
    let axes: Axis.Set
    let showsIndicator: Bool
    let onOffsetChanged: (CGPoint) -> Void
    let content: T
    
    private let coordinateSpaceName = "ScrollViewOrigin"
    
    init(axes: Axis.Set = .vertical,
         showsIndicator: Bool = true,
         onOffsetChanged: @escaping (CGPoint) -> Void = { _ in },
         @ViewBuilder content: () -> T
    ) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicator) {
            GeometryReader { proxy in
                Color.clear.preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(in: .named(coordinateSpaceName)).origin
                )
            }
            .frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: coordinateSpaceName)
        .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChanged)
    }
}

