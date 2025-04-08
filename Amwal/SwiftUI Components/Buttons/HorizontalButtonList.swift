//
//  HorizontalButtonList.swift
//  Dawak
//
//  Created by Taha Hussein on 27/02/2025.
//

import SwiftUI
struct HorizontalButtonList: View {
    let buttons: [(imageName: String, action: () -> Void)]
    var body: some View {
        HStack(spacing: 16) { 
            ForEach(buttons.indices, id: \.self) { index in
                let button = buttons[index]
                Button(action: button.action) {
                    Image(button.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(12)
                }
                .frame(width: 50, height: 50)
            }
        }
        .padding(.horizontal, 20)
    }
}
