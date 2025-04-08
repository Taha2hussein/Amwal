//
//  AnyButtonStyle.swift
//  Dawak
//
//  Created by Taha Hussein on 25/03/2025.
//

import SwiftUI
import Combine
struct AnyButtonStyle: ButtonStyle {
    private let _makeBody: (Configuration) -> AnyView

    init<T: ButtonStyle>(_ style: T) {
        _makeBody = { configuration in AnyView(style.makeBody(configuration: configuration)) }
    }

    func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}
