//
//  LeftImageButton.swift
//  Dawak
//
//  Created by Taha Hussein on 27/02/2025.
//

import SwiftUI

struct LeftImageButton: View {
    let imageName: String
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Spacer()
                Text(title)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50)
        }
        .buttonStyle(RERSecondaryButtonStyle(borderColor: Color.black))
    }
}
