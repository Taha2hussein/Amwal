//
//  SwipeableHeaderView.swift
//  Amwal
//
//  Created by Taha Hussein on 08/04/2025.
//

import Foundation
import SwiftUI

struct SwipeableHeaderView: View {
    let titles = ["نمو","الرئيسية"]
    @Binding var selectedIndex: Int
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $selectedIndex) {
                ForEach(titles.indices, id: \.self) { index in
                    ZStack {
                        ForEach(titles.indices, id: \.self) { i in
                            Text(titles[i])
                                .font(.RERTitles.title1)
                                .foregroundColor(Color.actionDisabled)
                                .opacity(i == index ? 1 : 0.25)
                                .scaleEffect(i == index ? 1.0 : 0.8)
                                .offset(x: CGFloat(i - index) * geometry.size.width * 0.3)
                                .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                        }
                    }
                    .frame(width: 200, height: 60)
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .frame(height: 60)
    }
}
