//
//  UnderlinedButton.swift
//  Dawak
//
//  Created by Taha Hussein on 03/03/2025.
//

import SwiftUI

struct TextButton: View {
    let title: String
    let textColor: Color
    let isUnderlined: Bool
    let alignment: Alignment
    let width: CGFloat
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(textColor)
                .if(isUnderlined) { view in
                    view.underline()
                }
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .buttonStyle(RERPlainTextButtonStyle(textColor: textColor, alignment: alignment, width: width))
    }
}
