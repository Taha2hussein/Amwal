//
//  ImageModifier.swift
//  Dawak
//
//  Created by Taha Hussein on 22/03/2025.
//

import SwiftUI

struct CustomImageView: View {
    let imageName: String
    let size: CGSize?

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size?.width, height: size?.height)
    }
}
