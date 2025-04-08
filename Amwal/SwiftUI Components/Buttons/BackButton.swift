//
//  BackButton.swift
//  Dawak
//
//  Created by Taha Hussein on 11/03/2025.
//

import Foundation
import SwiftUI

struct BackButtonView: View {
    let action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
